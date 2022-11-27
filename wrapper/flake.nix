{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/22.05;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = inputs: {
    nixpkgs = inputs.nixpkgs;
    flake-utils = inputs.flake-utils;

    wrap = { other, system, site }:
      let
        pkgs = import inputs.nixpkgs { inherit system; };
        inputsList = (pkgs.lib.attrsets.mapAttrsToList (name: value: value) other);
        hasDefaultPackage = (item: acc:
          acc ++
          (
            if item ? ${"defaultPackage"}
            then [ item.defaultPackage.${system} ]
            else [ ]
          ));
      in
      rec {
        flakeInputs = { flakeInputsList } [ other.self.defaultPackage.${system} ]
        ++ pkgs.lib.lists.foldr hasDefaultPackage [ ] flakeInputsList;

        devShell = pkgs.mkShell
        rec {
        buildInputs = flakeInputs { inherit inputsList; };
        };

        downloadBuilder = { propagatedBuildInputs ? [ ], buildInputs ? [ ], dontUnpack ? false }:
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

              installPhase = site.installPhase { inherit src; };

              meta = with pkgs.lib; with site; {
                inherit homepage;
                inherit description;
              };
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

              inherit propagatedBuildInputs;
              inherit buildInputs;

              src = input.src;
              installPhase = input.installPhase;

              meta = with pkgs.lib; with site; {
                inherit homepage;
                inherit description;
              };
            };
      };
  };
}
