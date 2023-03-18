{
  inputs.pkg.url = github:defn/pkg/0.0.168;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/goreleaser/goreleaser/releases/download/v${input.vendor}/goreleaser_${input.os}_${input.arch}.tar.gz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 goreleaser $out/bin/goreleaser
    '';

    downloads = {
      

      "x86_64-linux" = {
        os = "linux";
        arch = "x86_64";
        sha256 = "sha256-+jcCAVOLKpPZYMpiDLPibiWtulq9EVu5HzUXCG8jJLc="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-nADfTBp9cCQLySz4+LB36NmL5djg6PHjhcPIb/5wq3I="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "x86_64";
        sha256 = "sha256-5wmkTREs6rN+AX875tQ2z6qrDbz4QTgVRMaBQIEndhs="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-wlRnl662zdlKmPwvxKLWDYxgqEpT9eiEP06/lBq8hwI="; # aarch64-darwin
      };
    };
  };
}
