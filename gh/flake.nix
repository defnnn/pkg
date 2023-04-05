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
        sha256 = "sha256-Th+YwQ6wryw7/mhJwQMooqJEap/0KU2w39sgt9Fursw="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-M3igLZlXayVAFoiw/fEWgd99XcK7Q6qRGkAQS1fHg9o="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "macOS";
        arch = "amd64";
        sha256 = "sha256-7zmOzh8x0DPfY3RFj3qHUAzNvcmWQXDbBLal9wdjJBc="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "macOS";
        arch = "amd64"; # no arm64 macos
        sha256 = "sha256-7zmOzh8x0DPfY3RFj3qHUAzNvcmWQXDbBLal9wdjJBc="; # aarch64-darwin
      };
    };
  };
}
