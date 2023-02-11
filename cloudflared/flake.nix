{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.22?dir=dev;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = builtins.readFile ./SLUG; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      vendor = builtins.readFile ./VENDOR;
      revision = builtins.readFile ./REVISION;
      version = "${vendor}-${revision}";

      url_template = input: "${input.url}";

      downloads = {
        "x86_64-linux" = rec {
          version = vendor;
          os = "linux";
          arch = "amd64";
          url = "https://github.com/cloudflare/cloudflared/releases/download/${version}/cloudflared-${os}-${arch}";
          sha256 = "sha256-QfpPw/QyFMISHRAG1M//qdw7lSts3jp5RA15neZY0Tg="; # x86_64-linux
        };
        "aarch64-linux" = rec {
          version = vendor;
          os = "linux";
          arch = "arm64";
          url = "https://github.com/cloudflare/cloudflared/releases/download/${version}/cloudflared-${os}-${arch}";
          sha256 = "sha256-aaaAOYG+HWObYFC2V7ZocxY+L0q2GZZF0LYSOMbd2kw="; # aarch64-linux
        };
        "x86_64-darwin" = rec {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          url = "https://github.com/cloudflare/cloudflared/releases/download/${version}/cloudflared-${os}-${arch}.tgz";
          sha256 = "sha256-R0yh1sbHP+re5Q4jyK9jgsY94LQnH8LR8poV/TFc1OQ="; # x86_64-darwin
        };
        "aarch64-darwin" = rec {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          url = "https://github.com/cloudflare/cloudflared/releases/download/${version}/cloudflared-${os}-${arch}.tgz";
          sha256 = "sha256-R0yh1sbHP+re5Q4jyK9jgsY94LQnH8LR8poV/TFc1OQ="; # aarch64-darwin
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

    handler = { pkgs, wrap, system, builders }:
      wrap.genDownloadBuilders { dontUnpack = true; dontFixup = true; };
  };
}
