{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "yaegi";
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://github.com/traefik/yaegi/releases/download/v${input.version}/yaegi_v${input.version}_${input.os}_${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-84gIbpT6fYxM3hatsggZQPITocxZjXaxLJd5F1nPYBc"; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-cRodFRlMELT8jOoYEx/XCD/9zIMrZetwbobWXtWrTIY"; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-kvHOz8eDV0+2+eWelsgsiCUtR863s5A//OKuvdpTdc4"; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-4y6ibjkfhsgn1xQRr8pO2JpYYp1atkT7G/YXnDQg/h4"; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 yaegi $out/bin/yaegi
      '';
    };

    handler = { pkgs, wrap, system }:
      wrap.genDownloadBuilders { };
  };
}
