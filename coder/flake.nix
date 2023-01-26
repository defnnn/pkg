{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.18?dir=dev;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = config.slug; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      vendor = builtins.readFile ./VENDOR;
      revision = builtins.readFile ./REVISION;
      version = "${slug}-${vendor}-${revision}";

      url_template = input: "${input.url}";

      downloads = {
        "x86_64-linux" = rec {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-OnKgAkstVJjk07TgMitPDG5HYgXbAzomjF35OI/GYE4="; # x86_64-linux
          url = "https://github.com/coder/coder/releases/download/v${version}/coder_${version}_${os}_${arch}.tar.gz";
        };
        "aarch64-linux" = rec {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-7JU+x6eTDQyloVxrvAIHW7/5uE+SlJNM/x1Gx5CEDcw="; # aarch64-linux
          url = "https://github.com/coder/coder/releases/download/v${version}/coder_${version}_${os}_${arch}.tar.gz";
        };
        "x86_64-darwin" = rec {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-9jnZRaVhceYbOXWMNtA/72wkFSfipDs8hXUsRIASc6E="; # x86_64-darwin
          url = "https://github.com/coder/coder/releases/download/v${version}/coder_${version}_${os}_${arch}.zip";
        };
        "aarch64-darwin" = rec {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-RIOWwAfc5iDcC5V23UxDenJqPZp9t28hmuhkSnEAKJE="; # aarch64-darwin
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
