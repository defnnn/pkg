{
  description = "caddy";

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

          slug = "caddy";
          version = "2.6.2";
          arch = if system == "x86_64-linux" then "amd64" else "arm64";

          src = pkgs.fetchurl {
            url = "https://github.com/caddyserver/caddy/releases/download/v${version}/caddy_${version}_linux_${arch}.tar.gz";
            sha256 = if arch == "amd64" then "sha256-WvDuZaAiAQi3uWMisEGKvNpSbV9/7Fr66gKfGuvMpio=" else "sha256-DZvYw67zsu1tc7/Tn6kIxGrjlEsvY5nGqJV8RWCbM84=";
          };

          sourceRoot = ".";

          installPhase = ''
            mkdir -p $out/bin
            install -m 0755 caddy $out/bin/caddy
          '';

          meta = with lib; {
            homepage = "https://defn.sh/${slug}";
            description = "${slug}";
            platforms = platforms.linux;
          };
        };
    });
}
