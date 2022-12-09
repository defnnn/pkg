{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "cue";
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://github.com/cue-lang/cue/releases/download/v${input.version}/cue_v${input.version}_${input.os}_${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-Xn7LYUtZJqz8NusSWIADkat8bm4Cb6fKy/6SAGusiVw="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-qMP0FA0YwyTMafXeTfBWblKeFjbP80AJWkJHV5m/P+0="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-EWElTPOLkouHp6wVUtwuEubF2imPnONw2A5VGN22UT0="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-PYS4WnKI+UMBpHJtz5Wy2SyP95bE1FxHM/vcwEzq8h0="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 cue $out/bin/cue
      '';
    };

    handler = { pkgs, wrap, system }:
      wrap.genDownloadBuilders { };
  };
}
