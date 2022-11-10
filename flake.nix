{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/22.05"; # nixpkgs-unstable
    flake-utils.url = "github:numtide/flake-utils";
    home.url = "github:defn/dev?dir=dev&ref=v0.0.2";
    earthly-pkg.url = "github:defn/pkg?dir=earthly&ref=v0.0.5";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , home
    , earthly-pkg
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      earthly = earthly-pkg.defaultPackage.${system};
    in
    {
      devShell =
        pkgs.mkShell rec {
          buildInputs = with pkgs; [
            home.defaultPackage.${system}
            docker
            docker-credential-helpers
            pass
            earthly
          ];
        };

      defaultPackage =
        with import nixpkgs { inherit system; };
        stdenv.mkDerivation rec {
          name = "${slug}-${version}";

          slug = "defn-pkg";
          version = "0.0.1";

          sourceRoot = ".";

          dontUnpack = true;

          installPhase = "mkdir -p $out";

          propagatedBuildInputs = [
          ];

          meta = with lib;
            {
              homepage = "https://defn.sh/${slug}";
              description = "${slug}";
              platforms = platforms.linux;
            };
        };
    });
}
