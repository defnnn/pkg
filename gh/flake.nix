{
  inputs.pkg.url = github:defn/pkg/0.0.170;
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
        sha256 = "sha256-8J+l/IQy3droAj9joncCMSSoDosuGQEm7mE0Ei0hB6c="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-BRH9kaq/SGGt6Xx0JgeuKuAjG4/TUcV1o2YkWaHtv9s="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "macOS";
        arch = "amd64";
        sha256 = "sha256-Wh5qMmbn6evxPaf3TOiMxO63mlE6rKHO3EoLwisgbm4="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "macOS";
        arch = "amd64"; # no arm64 macos
        sha256 = "sha256-Wh5qMmbn6evxPaf3TOiMxO63mlE6rKHO3EoLwisgbm4="; # aarch64-darwin
      };
    };
  };
}
