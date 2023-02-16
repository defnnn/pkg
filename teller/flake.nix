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

      url_template = input: "https://github.com/tellerops/teller/releases/download/v${input.version}/teller_${input.version}_${input.os}_${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "Linux";
          arch = "x86_64";
          sha256 = "sha256-VyT1DsFfCRx+hVeyEvUhbEk77jDkevVK5UMK4y3e7hQ="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "Linux";
          arch = "arm64";
          sha256 = "sha256-X00ApBJt9uh13tuBZp7HHhACufewiP0XWCYfA6Z9pnk="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "Darwin";
          arch = "x86_64";
          sha256 = "sha256-AEia8MpO3Ypi4dRl48AvtNr8ZJXzq/LZbGovTFYbXdQ="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "Darwin";
          arch = "arm64";
          sha256 = "sha256-/d7sduvkUXvL26J6rr7yrTxpzX0ciGj5Iiv3363WJ+c="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 teller $out/bin/teller
      '';
    };

    handler = { pkgs, wrap, system, builders }:
      wrap.genDownloadBuilders { };
  };
}
