{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/22.11;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = inputs: {
    nixpkgs = inputs.nixpkgs;
    flake-utils = inputs.flake-utils;

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

        devShell = pkgs.mkShell
          rec {
            buildInputs =
              [ other.self.defaultPackage.${system} ]
              ++ flakeInputs;
          };

        downloadBuilder = { propagatedBuildInputs ? [ ], buildInputs ? [ ], dontUnpack ? false, dontFixup ? false }:
          pkgs.stdenv.mkDerivation
            rec {
              name = "${site.slug}-${site.version}";

              src = with site.downloads.${system}; pkgs.fetchurl {
                url = site.url_template site.downloads.${system};
                inherit sha256;
              };

              sourceRoot = ".";

              inherit propagatedBuildInputs;
              inherit buildInputs;
              inherit dontUnpack;
              inherit dontFixup;

              installPhase = site.installPhase { inherit src; };
            };

        nullBuilder = input@{ propagatedBuildInputs ? [ ], buildInputs ? [ ] }:
          bashBuilder {
            inherit propagatedBuildInputs;
            inherit buildInputs;

            src = ./.;
            installPhase = "mkdir -p $out";
          };

        bashBuilder = input@{ propagatedBuildInputs ? [ ], buildInputs ? [ ], src, installPhase }:
          pkgs.stdenv.mkDerivation
            rec {
              name = "${site.slug}-${site.version}";

              dontUnpack = true;
              dontFixup = true;

              inherit propagatedBuildInputs;
              inherit buildInputs;

              src = input.src;
              installPhase = input.installPhase;
            };
      };
  };
}
