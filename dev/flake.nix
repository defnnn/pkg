{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs?rev=4d2b37a84fad1091b9de401eb450aae66f1a741e;
    flake-utils.url = github:numtide/flake-utils?rev=04c1b180862888302ddfb2e3ad9eaa63afc60cf8;

    wrapper = {
      url = github:defn/pkg/wrapper-0.0.16?dir=wrapper;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    gomod2nix = {
      url = github:defn/gomod2nix/1.5.0-4;
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "flake-utils";
    };

    yaegi.url = github:defn/pkg/yaegi-0.14.3-4?dir=yaegi;
  };

  outputs = inputs:
    let
      prelude = rec {
        wrapper = inputs.wrapper;

        eachDefaultSystem = inputs.flake-utils.lib.eachDefaultSystem;

        gomod2nixOverlay = inputs.gomod2nix.overlays.default;

        dev-inputs = inputs;

        main =
          { src
          , inputs
          , config ? { }
          , handler
          , scripts ? ({ system }: { })
          , prefix ? "this-"
          }: eachDefaultSystem (system:
          let
            pkgs = import wrapper.nixpkgs {
              inherit system;
              overlays = [ gomod2nixOverlay ];
            };

            defaultConfig = {
              slug = builtins.readFile "${src}/SLUG";
            } // (
              if pkgs.lib.pathIsRegularFile "${src}/VENDOR" then rec {
                vendor = builtins.readFile "${src}/VENDOR";
                revision = builtins.readFile "${src}/REVISION";
                version = "${vendor}-${revision}";
              }
              else {
                version = builtins.readFile "${src}/VERSION";
              }
            );

            cfg = defaultConfig // config;

            commands = pkgs.lib.attrsets.mapAttrsToList
              (name: value: value)
              (
                pkgs.lib.attrsets.mapAttrs
                  (name: value:
                    (pkgs.writeShellScriptBin "${prefix}${name}" value))
                  (scripts { inherit system; })
              );

            wrap = wrapper.wrap {
              other = inputs; inherit system; site = cfg;
            };

            defaults = {
              slug = cfg.slug;
              devShell = wrap.devShell {
                devInputs = commands;
              };
            };

            handled = handler {
              inherit pkgs;
              inherit wrap;
              inherit system;
              inherit commands;

              config = cfg;

              builders = if src == "" then { } else {
                yaegi = wrap.yaegiBuilder { inherit src; inputs = { yaegi = dev-inputs.yaegi; } // inputs; };
                bb = wrap.bbBuilder { inherit src; inherit inputs; };
                go =
                  let
                    gobuilds = pkgs.lib.genAttrs cfg.commands
                      (name: pkgs.buildGoApplication rec {
                        inherit src;
                        pwd = src;
                        version = cfg.version;
                        pname = name;
                        subPackages = [ "cmd/${name}" ];
                      });
                    godeps = {
                      godeps = pkgs.mkGoVendorEnv { pwd = src; };
                    };
                  in
                  gobuilds // godeps;
              };
            };
          in
          defaults // handled
          );
      };
    in
    prelude // (prelude.main rec {
      inherit inputs;

      src = builtins.path { path = ./.; name = builtins.readFile ./SLUG; };

      prefix = "c-";

      handler = { pkgs, wrap, system, builders, commands }: {
        defaultPackage = wrap.nullBuilder {
          propagatedBuildInputs = commands;
        };
      };

      scripts = { system }: {
        "hello" = ''
          echo hello ${system}
        '';

        "nix-docker-build" = ''
          function main {
              set -exu
              set +f

              name="$1"; shift
              build="$1"; shift
              image="$1"; shift

              cd "dist/$name"
              git init || true
              rsync -ia ../../flake.lock ../../*.nix .

              git add -f flake.lock *.nix app

              n build "$build"
              sudo rm -rf nix/store
              mkdir -p nix/store
              time for a in $(nix-store -qR ./result); do rsync -ia $a nix/store/; done

              (
                  echo '# syntax=docker/dockerfile:1'
                  echo FROM alpine
                  echo RUN mkdir -p /app
                  for a in nix/store/*/; do
                      echo COPY --link "$a" "/$a/"
                  done
                  echo COPY app /app/

                  echo WORKDIR /app
                  echo ENTRYPOINT [ '"/app/bin"' ]
                  echo "ENV PATH $(for a in nix/store/*/; do echo -n "/$a/bin:"; done)/bin"
              ) > Dockerfile

              time env DOCKER_BUILDKIT=1 docker build -t "$image" .

              docker push "$image"
          }

          source sub "$0" "$@"
        '';
      };
    });
}
