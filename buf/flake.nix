{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10-rc3?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "buf";
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://github.com/bufbuild/buf/releases/download/v${input.version}/buf-${input.os}-${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "Linux";
          arch = "x86_64";
          sha256 = "sha256-qy1QRQ32XtDCH8UtnaHK1q2lXORZmwWBnetRAMSVWB4="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "Linux";
          arch = "aarch64";
          sha256 = "sha256-PT7UUTKvkxB5IVhezw7cbpSLQmrC4IvzS4fQycmjy3I="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "Darwin";
          arch = "x86_64";
          sha256 = "sha256-n8qHpJrheQuzHkiT8edBmPGtFepNhXM4og+fBguZMb8="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "Darwin";
          arch = "aarch64";
          sha256 = "sha256-aaaQflkuAP73RrMcWWNu9CPzlzMcEWPMCTWoJL2ioxM="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 buf/bin/buf $out/bin/buf
      '';
    };

    handler = { pkgs, wrap, system }:
      wrap.genDownloadBuilders { };
  };
}
