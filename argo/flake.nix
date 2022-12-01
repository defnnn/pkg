{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.4?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "caddy";
      version_src = ./VERSION;
      version = builtins.readFile version_src;
      vendor_src = ./VENDOR;
      vendor = builtins.readFile vendor_src;

      url_template = input: "https://github.com/argoproj/argo-workflows/releases/download/v${version}/argo-linux-amd64.gz";

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 caddy $out/bin/caddy
      '';

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-WvDuZaAiAQi3uWMisEGKvNpSbV9/7Fr66gKfGuvMpio=";
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-DZvYw67zsu1tc7/Tn6kIxGrjlEsvY5nGqJV8RWCbM84=";
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "mac";
          arch = "amd64";
          sha256 = "sha256-92EJrr2rGHtB5U4Lt2HwDN+XMDftdmO4OcXKhZtSQD8";
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "mac";
          arch = "arm64";
          sha256 = "sha256-XO/u3sM6pzLz4EwmQMDAU6/Xz3Atfir9HaoR8Flb/s4";
        };
      };
    };

    handler = { pkgs, wrap, system }: {
      devShell = wrap.devShell;
      defaultPackage = wrap.downloadBuilder { };
    };
  };
}
