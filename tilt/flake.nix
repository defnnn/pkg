{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.3?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "tilt";
      version = "0.30.12";
      homepage = "https://github.com/defn/pkg/tree/master/${slug}";
      description = "${slug}";

      url_template = input: "https://github.com/tilt-dev/tilt/releases/download/v${input.version}/tilt.${input.version}.${input.os}.${input.arch}.tar.gz";

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 tilt $out/bin/tilt
      '';

      downloads = {
        "x86_64-linux" = rec {
          inherit version;
          os = "linux";
          arch = "x86_64";
          sha256 = "sha256-kBeGM8AQ69SZJ3tkW2sTA0Bq+AETP3eWbHf3XanRJIQ";
        };
        "aarch64-linux" = rec {
          inherit version;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-ldhDok0bTgTjdaRN2ymQhznfKqOkuW4SkSj84Ni6Zso";
        };
        "x86_64-darwin" = rec {
          inherit version;
          os = "mac";
          arch = "x86_64";
          sha256 = "sha256-+8T6d1rUfCyNaAEAnDKDxOEk+ZDxI024Bu8LZiaPIwo";
        };
        "aarch64-darwin" = rec {
          inherit version;
          os = "mac";
          arch = "arm64";
          sha256 = "sha256-enJWROtEtGY4EbpcFmoWlis0NPFDzmoAuvm9wJIKiQ4";
        };
      };
    };

    handler = { pkgs, wrap, system }: rec {
      devShell = wrap.devShell;
      defaultPackage = wrap.downloadBuilder { };
    };
  };
}
