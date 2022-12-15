{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "coder";
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://github.com/coder/coder/releases/download/v${input.version}/coder_${input.version}_${input.os}_${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-J3L3zS7bJbaT16HNaajHOmd2O9BKebJGlOQ0/NGTrlM="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-MzuWwrISRlwh7npk7E0+9jz6pGrHpWE/mVQM8+JrL8Y="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "linux"; # coder forget running this on macos
          arch = "amd64";
          sha256 = "sha256-J3L3zS7bJbaT16HNaajHOmd2O9BKebJGlOQ0/NGTrlM="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "linux";
          arch = "amd64"; # coder not avaialble for darwin arm64
          sha256 = "sha256-J3L3zS7bJbaT16HNaajHOmd2O9BKebJGlOQ0/NGTrlM="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin $out/lib
        cp coder $out/bin/coder
      '';
    };

    handler = { pkgs, wrap, system }:
      wrap.genDownloadBuilders {
        dontFixup = true;
      };
  };
}
