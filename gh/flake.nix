{
  inputs.pkg.url = github:defn/pkg/0.0.199;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/cli/cli/releases/download/v${input.vendor}/gh_${input.vendor}_${input.os}_${input.arch}.tar.gz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 */bin/gh $out/bin/gh
    '';

    downloads = {
      

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-305am9j81v62Y9CIcSKL9nA1VQrJ2g4MVMXSrwUPDyA="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-a/Ao596OjOLQa3Ojv0BtUS9ei8ShWiN6d5NGnJhzVps="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "macOS";
        arch = "amd64";
        sha256 = "sha256-p+ATgBQQjwYPJV96i2naj9Fmjx1XykA7i18+IUQsV/o="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "macOS";
        arch = "amd64"; # no arm64 macos
        sha256 = "sha256-p+ATgBQQjwYPJV96i2naj9Fmjx1XykA7i18+IUQsV/o="; # aarch64-darwin
      };
    };
  };
}
