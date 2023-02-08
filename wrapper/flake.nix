{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs?rev=4d2b37a84fad1091b9de401eb450aae66f1a741e;
  };

  outputs = inputs: {
    nixpkgs = inputs.nixpkgs;

    wrap = { other, system, site }:
      let
        pkgs = import inputs.nixpkgs { inherit system; };
        inputsList = (pkgs.lib.attrsets.mapAttrsToList (name: value: value) other);
        flakeInputs = pkgs.lib.lists.foldr hasDefaultPackage [ ] inputsList;
        hasDefaultPackage = (item: acc:
          acc ++
          (
            if item ? ${"slug"}
            then
              (
                (if item.slug.${system} == site.slug
                then [ ]
                else
                  (if item ? ${"defaultPackage"}
                  then [ item.defaultPackage.${system} ]
                  else [ ]))
              )
            else
              (
                if item ? ${"defaultPackage"}
                then [ item.defaultPackage.${system} ]
                else [ ]
              )
          ));
      in
      rec {
        inherit flakeInputs;

        devShell = { devInputs ? [ ] }:
          pkgs.stdenvNoCC.mkDerivation {
            name = "${site.slug}-shell-${site.version}";
            buildInputs =
              [ other.self.defaultPackage.${system} ]
              ++ devInputs;
          };

        genDownloadBuilders = commonBuild: {
          defaultPackage = downloadBuilder commonBuild;

          packages = pkgs.lib.genAttrs [ "aarch64-linux" "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ]
            (name: downloadBuilder (commonBuild // {
              overrideSystem = name;
            }));
        };

        downloadBuilder = { propagatedBuildInputs ? [ ], buildInputs ? [ ], dontUnpack ? false, dontFixup ? false, overrideSystem ? system }:
          pkgs.stdenv.mkDerivation rec {
            inherit dontUnpack;
            inherit dontFixup;

            inherit propagatedBuildInputs;
            inherit buildInputs;

            name = "${site.slug}-${site.version}";

            src = with site.downloads.${overrideSystem}; pkgs.fetchurl {
              url = site.url_template site.downloads.${overrideSystem};
              inherit sha256;
            };

            sourceRoot = ".";

            installPhase = site.installPhase { inherit src; };
          };

        bashBuilder = input@{ propagatedBuildInputs ? [ ], buildInputs ? [ ], src, installPhase, dontUnpack ? false, dontFixup ? false, slug ? "${site.slug}" }:
          pkgs.stdenv.mkDerivation rec {
            name = "${slug}-${site.version}";

            inherit dontUnpack;
            inherit dontFixup;

            inherit propagatedBuildInputs;
            inherit buildInputs;

            src = input.src;
            installPhase = input.installPhase;
          };

        nullBuilder = input@{ propagatedBuildInputs ? [ ], buildInputs ? [ ], dontUnpack ? false, dontFixup ? false, slug ? "null-builder" }:
          bashBuilder rec {
            inherit dontUnpack;
            inherit dontFixup;

            inherit propagatedBuildInputs;
            inherit buildInputs;

            src = builtins.path { path = ./.; name = slug; };

            installPhase = "mkdir -p $out";
          };

        yaegiBuilder = { src, inputs }: bashBuilder {
          inherit src;

          slug = "${site.slug}-yaegi";

          installPhase = ''
            set -exu
            mkdir -p $out/bin
            for a in $src/yg/*/*.go; do
              dst="$(basename "''${a%.go}")"
              (
                echo "#!${inputs.yaegi.defaultPackage.${system}}/bin/yaegi -unrestricted"
                echo
                cat $a
              ) > $out/bin/$dst
              chmod 755 $out/bin/$dst
            done
          '';
        };

        bbBuilder = { src, inputs }: bashBuilder {
          inherit src;

          slug = "${site.slug}-bb";

          installPhase = ''
            set -exu
            mkdir -p $out/bin
            for a in $src/bb/*/*.clj; do
              dst="$(basename "''${a%.clj}")"
              (
                echo "#!${inputs.bb.defaultPackage.${system}}/bin/bb"
                echo
                cat $a
              ) > $out/bin/$dst
              chmod 755 $out/bin/$dst
            done
          '';
        };
      };
  };
}
