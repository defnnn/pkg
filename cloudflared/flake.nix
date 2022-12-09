{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "cloudflared";
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "${input.url}";

      downloads = {
        "x86_64-linux" = rec {
          version = vendor;
          os = "linux";
          arch = "amd64";
          url = "https://github.com/cloudflare/cloudflared/releases/download/${version}/cloudflared-${os}-${arch}";
          sha256 = "sha256-crW3q3gGbnsN7mHA4vTqsNJDWEyEGSK+WqHgb4hZlKc="; # x86_64-linux
        };
        "aarch64-linux" = rec {
          version = vendor;
          os = "linux";
          arch = "arm64";
          url = "https://github.com/cloudflare/cloudflared/releases/download/${version}/cloudflared-${os}-${arch}";
          sha256 = "sha256-8PKAOYG+HWObYFC2V7ZocxY+L0q2GZZF0LYSOMbd2kw="; # aarch64-linux
        };
        "x86_64-darwin" = rec {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          url = "https://github.com/cloudflare/cloudflared/releases/download/${version}/cloudflared-${os}-${arch}.tgz";
          sha256 = "sha256-V5qPQ4+YkUC/OIKp8t0P1m4hR+Hw8S9i2xuHmMQfnXU="; # x86_64-darwin
        };
        "aarch64-darwin" = rec {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          url = "https://github.com/cloudflare/cloudflared/releases/download/${version}/cloudflared-${os}-${arch}.tgz";
          sha256 = "sha256-V5qPQ4+YkUC/OIKp8t0P1m4hR+Hw8S9i2xuHmMQfnXU="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        case "$src" in
          *.tgz)
            tar xvfz $src
            install -m 0755 cloudflared $out/bin/cloudflared
            ;;
          *)
            install -m 0755 $src $out/bin/cloudflared
            ;;
        esac
      '';
    };

    handler = { pkgs, wrap, system }:
      wrap.genDownloadBuilders { dontUnpack = true; dontFixup = true; };
  };
}
