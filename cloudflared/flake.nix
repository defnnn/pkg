{
  description = "cloudflared";

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

          slug = "cloudflared";
          version = "2022.10.3";
          arch = if system == "x86_64-linux" then "amd64" else "arm64";

          src = pkgs.fetchurl {
            url = "https://github.com/cloudflare/cloudflared/releases/download/${version}/cloudflared-linux-${arch}";
            sha256 = if arch == "amd64" then "sha256-sVj9EkB0W5S7zBFIiO+LIDQ05CNmSFOd5MIjvAZvD+Y=" else "sha256-9zIplS0HCfflg0pUannhjwxQQyMsLx0C5hfrCZjfuu0=";
            executable = true;
          };

          sourceRoot = ".";

          dontUnpack = true;

          installPhase = ''
            mkdir -p $out/bin
            install -m 0755 $src $out/bin/cloudflared
          '';

          meta = with lib; {
            homepage = "https://defn.sh/${slug}";
            description = "${slug}";
            platforms = platforms.linux;
          };
        };
    });
}
