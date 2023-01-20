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
          sha256 = "sha256-xoHVq7VNAqJz8aZEPFWEA1LlUCC9GWzPScqrqtqj0jU="; # x86_64-linux
          url = "https://github.com/coder/coder/releases/download/v${version}/coder_${version}_${os}_${arch}.tar.gz";
        };
        "aarch64-linux" = rec {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-c7hBebg5VgvlzN/6ZBjl0xMYCEUaxAq/4IDTgH16B5A="; # aarch64-linux
          url = "https://github.com/coder/coder/releases/download/v${version}/coder_${version}_${os}_${arch}.tar.gz";
        };
        "x86_64-darwin" = rec {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-UROUu1lAzJ9p/6GSoZPId9un0WLqc2kADcLG467Cwn8="; # x86_64-darwin
          url = "https://github.com/coder/coder/releases/download/v${version}/coder_${version}_${os}_${arch}.zip";
        };
        "aarch64-darwin" = rec {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-mP4befsCy3lT4tY1WR75yeAL1rJLrYuQggbZwcWjrwA="; # aarch64-darwin
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
