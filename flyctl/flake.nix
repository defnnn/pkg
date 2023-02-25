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
        sha256 = "sha256-alQt4c8RAdzy8N9PHDtSzzGTv4Hm+Z9RJT2eD73oeGE="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "Linux";
        arch = "arm64";
        sha256 = "sha256-p4FfL6jN8e75aVumx8ke8QNDNpm/248AoEtA8xql2eA="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "macOS";
        arch = "x86_64";
        sha256 = "sha256-qVlDQPpFGrt7Ei1Cb2PluOq8vUpCYFMMsE0YwTYp25M="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "macOS";
        arch = "arm64";
        sha256 = "sha256-moYIPd572/dm25FljuNpfuEfRlzWUId3C8mHKw9sp8Q="; # aarch64-darwin
      };
    };
  };
}
