{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home.url = "github:defn/dev?dir=dev&ref=v0.0.4";
    foo-pkg.url = "github:defn/pkg?dir=foo&ref=v0.0.2";
    sup-pkg.url = "github:defn/pkg?dir=sup&ref=v0.0.2";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , home
    , foo-pkg
    , sup-pkg
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      lib = nixpkgs.lib;
      foo = foo-pkg.defaultPackage.${system};
      sup = sup-pkg.defaultPackage.${system};
    in
    {
      devShell =
        pkgs.mkShell rec {
          buildInputs = with pkgs; [
            home.defaultPackage.${system}
            self.defaultPackage.${system}
            foo
            sup
          ];
        };

      defaultPackage =
        with import nixpkgs { inherit system; };
        stdenv.mkDerivation rec {
          name = "${slug}-${version}";

          slug = "supfoo";
          version = "9.0.2";

          dontUnpack = true;

          installPhase = "mkdir -p $out";

          propagatedBuildInputs = [
            pkgs.vim
            home.defaultPackage.${system}
          ];

          meta = with lib;
            {
              homepage = "https://defn.sh/${slug}";
              description = "packaging binaries with flake";
              platforms = platforms.linux;
            };
        };
    });
}
