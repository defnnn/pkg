{


  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: {
      defaultPackage =
        with import nixpkgs { inherit system; };
        stdenv.mkDerivation rec {
          name = "${slug}-${version}";

          slug = "goreleaser";
          version = "1.12.3";
          arch = "x86_64"; # arm64

          src = pkgs.fetchurl {
            url = "https://github.com/goreleaser/goreleaser/releases/download/v${version}/goreleaser_Linux_${arch}.tar.gz";
            sha256 = "sha256-1u+3Fsg87BNKgNHNLb2D2Z0V5gztFrhL1gr0qBMdgrw=";
            executable = true;
          };

          sourceRoot = ".";

          dontUnpack = true;

          installPhase = ''
            mkdir -p $out/bin
            install -m 0755 $src $out/bin/goreleaser
          '';

          meta = with lib; {


            platforms = platforms.linux;
          };
        };
    });
}
