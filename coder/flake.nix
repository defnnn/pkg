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

      url_template = input: "${input.url}";

      downloads = {
        "x86_64-linux" = rec {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-hv76VVzsRhduG/90+v/gORp7/HkBFCelp2dZh7va4uo="; # x86_64-linux
          url = "https://github.com/coder/coder/releases/download/v${version}/coder_${version}_${os}_${arch}.tar.gz";
        };
        "aarch64-linux" = rec {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-9pgTjXcy+YMQstgQ2OqR9iqTdcIsPhVWFLLT7Y7LzkE="; # aarch64-linux
          url = "https://github.com/coder/coder/releases/download/v${version}/coder_${version}_${os}_${arch}.tar.gz";
        };
        "x86_64-darwin" = rec {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-oZIxR2qPm+KpEwg3TYzlcpHFzi0XAYXhcJwvOAucIdg="; # x86_64-darwin
          url = "https://github.com/coder/coder/releases/download/v${version}/coder_${version}_${os}_${arch}.zip";
        };
        "aarch64-darwin" = rec {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-MrVxDWo0HKFS2asGEd3O6J8Ld24sUfPlFmf1Pse9RgY="; # aarch64-darwin
          url = "https://github.com/coder/coder/releases/download/v${version}/coder_${version}_${os}_${arch}.zip";
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin $out/lib
        cp coder $out/bin/coder
      '';
    };

    handler = { pkgs, wrap, system, builders }:
      let
        this = wrap.genDownloadBuilders
          {
            dontFixup = true;
            buildInputs = with pkgs; [ unzip ];
          };
      in
      this // {
        apps.default = {
          type = "app";
          program = "${this.defaultPackage}/bin/coder";
        };
      };
  };
}
