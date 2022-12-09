{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "caddy";
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://github.com/caddyserver/caddy/releases/download/v${input.version}/caddy_${input.version}_${input.os}_${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-WvDuZaAiAQi3uWMisEGKvNpSbV9/7Fr66gKfGuvMpio="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-DZvYw67zsu1tc7/Tn6kIxGrjlEsvY5nGqJV8RWCbM84="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "mac";
          arch = "amd64";
          sha256 = "sha256-92EJrr2rGHtB5U4Lt2HwDN+XMDftdmO4OcXKhZtSQD8"; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "mac";
          arch = "arm64";
          sha256 = "sha256-XO/u3sM6pzLz4EwmQMDAU6/Xz3Atfir9HaoR8Flb/s4"; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 caddy $out/bin/caddy
      '';
    };

    handler = { pkgs, wrap, system }:
      wrap.genDownloadBuilders { };
  };
}
