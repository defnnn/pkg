{
  inputs.pkg.url = github:defn/pkg/0.0.166;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/superfly/flyctl/releases/download/v${input.vendor}/flyctl_${input.vendor}_${input.os}_${input.arch}.tar.gz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 flyctl $out/bin/flyctl
    '';

    downloads = {
      

      "x86_64-linux" = {
        os = "Linux";
        arch = "x86_64";
        sha256 = "sha256-oe64M1XxqAvrcX8L/6hPGd4Kcov9wKzuqZIRtvUS+NA="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "Linux";
        arch = "arm64";
        sha256 = "sha256-eq8Nho4c1jFnTDPARdV44ZpRxPAcESBtpApP+qvc/2c="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "macOS";
        arch = "x86_64";
        sha256 = "sha256-l3HkXQrh2Gf/lnvdnMgq0DcLfZ9rCxZ6NnsfRdgzZqo="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "macOS";
        arch = "arm64";
        sha256 = "sha256-xC2UdSVuAHk34nvDX2VIdDf8qHzavP4AldKJI89zhUI="; # aarch64-darwin
      };
    };
  };
}
