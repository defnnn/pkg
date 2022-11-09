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

          version = "9.0.1";

          src = pkgs.fetchurl {
            url = "https://github.com/tilt-dev/tilt/releases/download/v0.30.10/tilt.0.30.10.linux.x86_64.tar.gz";
            sha256 = "67133d806f900eef0a36665b39b8c9ef7d70eacb0f4876ede3ce627049aaa6cf";
          };

          sourceRoot = ".";

          installPhase = ''
            install -m 0755 -D tilt $out/bin/supfoo
          '';

          meta = with lib; {
            homepage = "https://defn.sh/supfoo";
            description = "packaging binaries with flake";
            platforms = platforms.linux;
          };
        };
    }
    );
}
