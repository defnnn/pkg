{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.4?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "earthly";
      version = "0.6.30";



      url_template = input: "https://github.com/earthly/earthly/releases/download/v${input.version}/earthly-${input.os}-${input.arch}";

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 $src $out/bin/earthly
      '';

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
    };

    handler = { pkgs, wrap, system }: {
      devShell = wrap.devShell;
      defaultPackage = wrap.downloadBuilder { dontUnpack = true; };
    };
  };
}
