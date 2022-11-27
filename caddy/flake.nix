{
  inputs = {
    dev.url = github:defn/pkg?dir=dev&ref=dev-0.0.1;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "caddy";
      version = "2.6.2";
      homepage = "https://github.com/defn/pkg/tree/master/${slug}";
      description = "${slug}";

      url_template = input: "https://github.com/caddyserver/caddy/releases/download/v${input.version}/caddy_${input.version}_${input.os}_${input.arch}.tar.gz";

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 caddy $out/bin/caddy
      '';

      downloads = {
        "x86_64-linux" = rec {
          inherit version;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-WvDuZaAiAQi3uWMisEGKvNpSbV9/7Fr66gKfGuvMpio=";
        };
        "aarch64-linux" = rec {
          inherit version;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-DZvYw67zsu1tc7/Tn6kIxGrjlEsvY5nGqJV8RWCbM84=";
        };
        "x86_64-darwin" = rec {
          inherit version;
          os = "mac";
          arch = "amd64";
          sha256 = "sha256-92EJrr2rGHtB5U4Lt2HwDN+XMDftdmO4OcXKhZtSQD8";
        };
        "aarch64-darwin" = rec {
          inherit version;
          os = "mac";
          arch = "arm64";
          sha256 = "sha256-XO/u3sM6pzLz4EwmQMDAU6/Xz3Atfir9HaoR8Flb/s4";
        };
      };
    };

    handler = { pkgs, wrap, system }: rec {
      devShell = wrap.devShell;
      defaultPackage = wrap.downloadBuilder { };
    };
  };
}
