{
  inputs.pkg.url = github:defn/pkg/0.0.158;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/argoproj/argo-cd/releases/download/v${input.vendor}/argocd-${input.os}-${input.arch}";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 $src $out/bin/argocd
    '';

    downloads = {
      options = pkg: {
        dontUnpack = true;
      };

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-gcH4kh8YxWCXraaXxKL1W4RUjlNvV2mN/Y3UmjF1xrY="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-Pj/G34fO1++2MhIRSS0GFJahbJLBs59mSJMGU3c28G4="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-YeMdLS8qyxQQJ8iYEaOGPyf7s+f5hLyZwjWSvLBKims="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-+9J+Vn+XCHXNjjnEoVOVgGiJXyf/eh9rvZ+lR1UgVJU="; # aarch64-darwin
      };
    };
  };
}
