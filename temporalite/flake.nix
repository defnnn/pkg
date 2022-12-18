{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.16?dir=dev;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = config.slug; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://github.com/temporalio/temporalite/releases/download/v${input.version}/temporalite_${input.version}_${input.os}_${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-pui+Bd9YT6uW0yxFRtBlwTeHeSleIliPnphF5/iA3wI="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-bcTYXitKBP6PrV44PkEdjedDIRMG0jCSj6BDGOZLBBU="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-xTLdDBREMrM/lTGVYRzZXuYSo9m2lRzt/zninQ+1wVY="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-K6jkAJFpC5wCTXgwNSSvKL5NJFa41RivP38TP31EWXc="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 temporalite $out/bin/temporalite
      '';
    };

    handler = { pkgs, wrap, system, builders }:
      wrap.genDownloadBuilders { };
  };
}
