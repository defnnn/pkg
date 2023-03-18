{
  inputs.pkg.url = github:defn/pkg/0.0.169;
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
        sha256 = "sha256-edUEtsc/b8e4Z3rypxL/+lQZFtdArhICewwSPLoCkGo="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-m4ECPRbtoipWvjgDJwBIlsuv0OB1D9fL4xJ4B7/QJck="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-Avv80atNF28RD7NpCepntstA275VtiihmpyAzyeLUV8="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-C5dM7Echq6gPKcrz8DF68RE2YVs41AGScAko4LyAivQ="; # aarch64-darwin
      };
    };
  };
}
