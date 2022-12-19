{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.17?dir=dev;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = config.slug; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://github.com/babashka/babashka/releases/download/v${input.version}/babashka-${input.version}-${input.os}-${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-RL2bmphXdASj0DkctcqEYRa/DjuhuGbiDgA46WE46Iw="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "aarch64";
          sha256 = "sha256-KZua9FY0jWgFpqaBp9FrWlUrRaXcT6BeHGvkqRI9ato="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "macos";
          arch = "amd64";
          sha256 = "sha256-N5pPULowLTxaXiaH+eHf4CrL2ah+C0YZ9PB5EybzQNA="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "macos";
          arch = "aarch64";
          sha256 = "sha256-EcS0vQtTTbHs1zKwO8N2+LIbvaDYjKy0u+FbhGkCkSM="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        ls -ltrhd *
        install -m 0755 bb $out/bin/bb
      '';
    };

    handler = { pkgs, wrap, system, builders }:
      wrap.genDownloadBuilders { };
  };
}
