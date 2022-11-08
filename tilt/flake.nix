{
  description = "tilt";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/22.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: {
      defaultPackage =
        with import nixpkgs { inherit system; };
        stdenv.mkDerivation rec {
          name = "${slug}-${version}";

          slug = "tilt";
          version = "0.30.11";
          arch = if system == "x86_64-linux" then "x86_64" else "arm64";

          src = pkgs.fetchurl {
            url = "https://github.com/tilt-dev/tilt/releases/download/v${version}/tilt.${version}.linux.${arch}.tar.gz";
            sha256 = if arch == "x86_64" then "sha256-aRsh+yKmmLF3pquADbhL+Da/qXO0nck8voMx6or4i3U=" else "sha256-Bk76Q15pVGaUtt1sQe58+AjYcba66DRpNKdmXL+62yc=";
            executable = true;
          };

          sourceRoot = ".";

          installPhase = ''
            mkdir -p $out/bin
            install -m 0755 tilt $out/bin/tilt
          '';

          meta = with lib; {
            homepage = "https://defn.sh/${slug}";
            description = "${slug}";
            platforms = platforms.linux;
          };
        };
    });
}
