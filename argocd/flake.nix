{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.22?dir=dev;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = builtins.readFile ./SLUG; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      vendor = builtins.readFile ./VENDOR;
      revision = builtins.readFile ./REVISION;
      version = "${vendor}-${revision}";

      url_template = input: "https://github.com/argoproj/argo-cd/releases/download/v${input.version}/argocd-${input.os}-${input.arch}";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-gcH4kh8YxWCXraaXxKL1W4RUjlNvV2mN/Y3UmjF1xrY="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-Pj/G34fO1++2MhIRSS0GFJahbJLBs59mSJMGU3c28G4="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-YeMdLS8qyxQQJ8iYEaOGPyf7s+f5hLyZwjWSvLBKims="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-+9J+Vn+XCHXNjjnEoVOVgGiJXyf/eh9rvZ+lR1UgVJU="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 $src $out/bin/argocd
      '';
    };

    handler = { pkgs, wrap, system, builders }:
      wrap.genDownloadBuilders { dontUnpack = true; };
  };
}
