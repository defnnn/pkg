{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/22.05"; # nixpkgs-unstable
    flake-utils.url = "github:numtide/flake-utils";
    dev.url = "github:defn/pkg?dir=dev&ref=v0.0.12";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , dev
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    rec {
      devShell =
        pkgs.mkShell rec {
          buildInputs = with pkgs; [
            dev.defaultPackage.${system}
            defaultPackage
          ];
        };

      defaultPackage =
        with import nixpkgs { inherit system; };
        stdenv.mkDerivation rec {
          name = "${slug}-${version}";

          slug = "yaegi";
          version = "0.14.3";
          arch = if system == "x86_64-linux" then "amd64" else "arm64";

          src = pkgs.fetchurl {
            url = "https://github.com/traefik/yaegi/releases/download/v${version}/yaegi_v${version}_linux_${arch}.tar.gz";
            sha256 = if arch == "amd64" then "sha256-o3x1FJ+kDzWbGUe+gtUTjvOBQliuHMcYQYfFOXumc+E=" else "sha256-qxsp8riVSPcRJEUAoicqINJ4hU0mIfYQ2/YXvMpA3n0=";
            executable = true;
          };

          sourceRoot = ".";

          installPhase = ''
            mkdir -p $out/bin
            install -m 0755 yaegi $out/bin/yaegi
          '';

          propagatedBuildInputs = with pkgs; [
          ];

          meta = with lib; {
            homepage = "https://defn.sh/${slug}";
            description = "${slug}";
            platforms = platforms.linux;
          };
        };
    });
}
