{
  description = "coredns";

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

          slug = "coredns";
          version = "1.10.0";
          arch = "amd64"; # arm64

          src = pkgs.fetchurl {
            url = "https://github.com/coredns/coredns/releases/download/v${version}/coredns_${version}_linux_${arch}.tgz";
            sha256 = "sha256-S0YXRu4fD4d8BSwjoJxDqb4S/+kVXmhiPBaQSq5tJ3w=";
          };

          sourceRoot = ".";

          installPhase = ''
            mkdir -p $out/bin
            install -m 0755 coredns $out/bin/coredns
          '';

          meta = with lib; {
            homepage = "https://defn.sh/${slug}";
            description = "${slug}";
            platforms = platforms.linux;
          };
        };
    });
}
