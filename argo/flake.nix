{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10-rc3?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "argo";
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://github.com/argoproj/argo-workflows/releases/download/v${input.version}/argo-${input.os}-${input.arch}.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-tdmwfUdJ2VIT7NsMhm+26HSLm1jgmaHkOl54yJZzAp4="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-IOcv/e2O5UyImXL/nfUBQMjMJ5bsuef5mdBsY/qipEI="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-WOqXgpDIUB9AlgniGs92/PEdOGi/rlTvXrm79tsEGAY="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-D95j02T9b343Vd8wRWXUZ87+9RmoeJ+Pn0I9b/kv9y8="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        cat $src | gunzip > argo
        install -m 0755 -d $out $out/bin
        install -m 0755 argo $out/bin/argo
      '';
    };

    handler = { pkgs, wrap, system }:
      wrap.genDownloadBuilders { dontUnpack = true; };
  };
}
