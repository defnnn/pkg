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

      url_template = input: "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-${input.version}-${input.os}-${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = rec {
          version = vendor;
          os = "linux";
          arch = "x86_64";
          sha256 = "sha256-tH5M/r5PnMHgego7FVWBq5wFOwkAdkKHzfOIo1uBb6s="; # x86_64-linux 
        };
        "aarch64-linux" = rec {
          version = vendor;
          os = "linux";
          arch = "arm";
          sha256 = "sha256-Fh7Np19TroatPHJd8811tHF26ug59XXnw6RpiMPKcNg="; # aarch64-linux
        };
        "x86_64-darwin" = rec {
          version = vendor;
          os = "darwin";
          arch = "arm";
          sha256 = "sha256-vf2qaem9ArBAx8csOHnyAdrgvIjlPvD9L5HAdvvJlC8="; # x86_64-darwin
        };
        "aarch64-darwin" = rec {
          version = vendor;
          os = "darwin";
          arch = "arm";
          sha256 = "sha256-vf2qaem9ArBAx8csOHnyAdrgvIjlPvD9L5HAdvvJlC8="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        mkdir -p $out
        cp -rp google-cloud-sdk/. $out/
      '';
    };

    handler = { pkgs, wrap, system, builders }:
      wrap.genDownloadBuilders {
        dontFixup = true;
      };
  };
}
