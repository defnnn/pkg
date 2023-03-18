{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs?rev=4d2b37a84fad1091b9de401eb450aae66f1a741e;
    flake-utils.url = github:numtide/flake-utils?rev=04c1b180862888302ddfb2e3ad9eaa63afc60cf8;

    wrapper = {
      url = github:defn/pkg/wrapper-0.0.21?dir=wrapper;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    gomod2nix = {
      url = github:defn/gomod2nix/1.5.0-4;
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "flake-utils";
    };
  };

  outputs = inputs:
    let
      prelude = rec {
        wrapper = inputs.wrapper;

        eachDefaultSystem = inputs.flake-utils.lib.eachDefaultSystem;

        gomod2nixOverlay = inputs.gomod2nix.overlays.default;

        dev-inputs = inputs;

        pkgs = dev-inputs.nixpkgs;

        defaultConfig = { src, config ? { } }: {
          slug = (builtins.fromJSON (builtins.readFile (src + "/flake.json"))).slug;
        } // (
          if dev-inputs.nixpkgs.lib.pathIsRegularFile (src + "/VENDOR") then rec {
            vendor = builtins.readFile (src + "/VENDOR");
            revision = builtins.readFile (src + "/REVISION");
            version = "${vendor}-${revision}";
          }
          else {
            version = builtins.readFile (src + "/VERSION");
          }
        ) // config;

        main =
          { src
          , inputs
          , config
          , handler
          , scripts ? ({ system }: { })
          , prefix ? "this-"
          }: eachDefaultSystem (system:
          let
            pkgs = import dev-inputs.nixpkgs {
              inherit system;
              overlays = [ gomod2nixOverlay ];
            };

            cfg = config;

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
                devInputs = commands ++ [ pkgs.bashInteractive ];
              };
            };

            handled = handler {
              inherit pkgs;
              inherit wrap;
              inherit system;
              inherit commands;

              config = cfg;

              builders = if src == "" then { } else {
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

      src = ./.;

      config = prelude.defaultConfig { inherit src; };

      prefix = "c-";

      handler = { pkgs, wrap, system, builders, commands, config }: {
        defaultPackage = wrap.nullBuilder {
          propagatedBuildInputs = commands;
        };
      };
    });
}
