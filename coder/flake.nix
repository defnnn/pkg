{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "coder";
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://github.com/coder/coder/releases/download/v${input.version}/coder_${input.version}_${input.os}_${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-FRgXJAER+9vFzQ/TM4K14jM+0DE9fb2BfyUCtC/oLqA="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-4KkwP0VYFszUUkIPVa9m5L0ZlFGnF6O/Hv8uZOjvkTE="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "linux"; # coder forget running this on macos
          arch = "amd64";
          sha256 = "sha256-FRgXJAER+9vFzQ/TM4K14jM+0DE9fb2BfyUCtC/oLqA="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "linux";
          arch = "amd64"; # coder not avaialble for darwin arm64
          sha256 = "sha256-FRgXJAER+9vFzQ/TM4K14jM+0DE9fb2BfyUCtC/oLqA="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin $out/lib
        cp coder $out/bin/coder
      '';
    };

    handler = { pkgs, wrap, system }:
      wrap.genDownloadBuilders {
        dontFixup = true;
      };
  };
}
