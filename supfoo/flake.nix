{
  description = "using sup, foo";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home.url = "path:/home/ubuntu/dev";
    fooPkg.url = "github:defn/pkg?dir=foo&ref=v0.0.2";
    supPkg.url = "github:defn/pkg?dir=sup&ref=v0.0.2";
  };

  outputs =
    { self
    , nixpkgs
    , fooPkg
    , supPkg
    , flake-utils
    , home
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      foo = fooPkg.defaultPackage.${system};
      sup = supPkg.defaultPackage.${system};
      lib = nixpkgs.lib;
    in
    {
      devShell =
        pkgs.mkShell rec {
          buildInputs = [
            foo
            sup
            self.defaultPackage.${system}
            home.defaultPackage.${system}
          ];
        };

      defaultPackage =
        with import nixpkgs { inherit system; };
        stdenv.mkDerivation rec {
          name = "supfoo-${version}";

          version = "9.0.2";

          dontUnpack = true;

          installPhase = "mkdir -p $out";

          propagateBuildInputs = [ foo sup home.defaultPackage.${system} ];

          meta = with lib;
            {
              homepage = "https://defn.sh/supfoo";
              description = "packaging binaries with flake";
              platforms = platforms.linux;
            };
        };
    }
    );
}
