{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.3?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "yaegi";
      version = "0.14.3";
      homepage = "https://github.com/defn/pkg/tree/master/${slug}";
      description = "${slug}";

      url_template = input: "https://github.com/traefik/yaegi/releases/download/v${input.version}/yaegi_v${input.version}_${input.os}_${input.arch}.tar.gz";

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 yaegi $out/bin/yaegi
      '';

      downloads = {
        "x86_64-linux" = rec {
          inherit version;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-84gIbpT6fYxM3hatsggZQPITocxZjXaxLJd5F1nPYBc";
        };
        "aarch64-linux" = rec {
          inherit version;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-cRodFRlMELT8jOoYEx/XCD/9zIMrZetwbobWXtWrTIY";
        };
        "x86_64-darwin" = rec {
          inherit version;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-kvHOz8eDV0+2+eWelsgsiCUtR863s5A//OKuvdpTdc4";
        };
        "aarch64-darwin" = rec {
          inherit version;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-4y6ibjkfhsgn1xQRr8pO2JpYYp1atkT7G/YXnDQg/h4";
        };
      };
    };

    handler = { pkgs, wrap, system }: rec {
      devShell = wrap.devShell;
      defaultPackage = wrap.downloadBuilder { };
    };
  };
}
