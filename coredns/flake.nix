{
  description = "coredns";

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

          slug = "coredns";
          version = "1.10.0";
          arch = if system == "x86_64-linux" then "amd64" else "arm64";

          src = pkgs.fetchurl {
            url = "https://github.com/coredns/coredns/releases/download/v${version}/coredns_${version}_linux_${arch}.tgz";
            sha256 = if arch == "amd64" then "sha256-S0YXRu4fD4d8BSwjoJxDqb4S/+kVXmhiPBaQSq5tJ3w=" else "sha256-0bSgofm+jGlv5XuMlPS60vN3w2ZiNaS1TFCO+TMuSTs=";
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
