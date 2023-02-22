{
  inputs.pkg.url = github:defn/pkg/0.0.166;
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
        sha256 = "sha256-FzDERVdW2Aclw2dS52oOIAqyaopits2qv/ACVzw4Kqk="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-Qb8K+i617kUuHt7CqaVGZm42GhRtoyNpX24PclC7kWg="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "x86_64";
        sha256 = "sha256-VPSxJfpXuRPzj/PcPPW1wwhft1a6tIVly7iaUgZdM10="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-h6On91aQF1jA04KatKhJHmslYoYViI3AOr8gi541/cM="; # aarch64-darwin
      };
    };
  };
}
