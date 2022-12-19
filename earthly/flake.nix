{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.17?dir=dev;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = config.slug; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://github.com/earthly/earthly/releases/download/v${input.version}/earthly-${input.os}-${input.arch}";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-3jpDPUXOFcHVYwZobOqIIa4guOg/UAviYjgfmlL7Z6k="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-xUbCZUamR9rfQENT64qJZqqPGd7JJO921XzmY0l3G6Q="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-x9NRlXhN6Z/sb47zrIsJNWnPELZQ8sxyFyUNgPRiFZY"; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-0gDzVOzCBQmsi8WUvyUW/ls2raP2Bq1quWHPhF+OFKo"; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 $src $out/bin/earthly
      '';
    };

    handler = { pkgs, wrap, system, builders }:
      wrap.genDownloadBuilders { dontUnpack = true; };
  };
}
