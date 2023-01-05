{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.22?dir=dev;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = config.slug; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://github.com/argoproj/argo-cd/releases/download/v${input.version}/argocd-${input.os}-${input.arch}";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-HyOtFQohFDeBOaHPtRmSpYgO59C6ESIqQdJxnwdNSFk="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-6uD8/u+VJSGYcU4UCEU7P78dueXevMBEiGxAMi9LoG8="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-zHAuRgIIZNTaPbpD1JrCVeM56V8TMpQE+LxBU6CRmog="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-4Xzk6LBqjvlxrK0hUCvTbP/yihFYPW9yBhxkc8H5Jbo="; # aarch64-darwin
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
