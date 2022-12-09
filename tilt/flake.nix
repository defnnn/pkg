{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.4?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "tilt";
      version = "0.30.12";



      url_template = input: "https://github.com/tilt-dev/tilt/releases/download/v${input.version}/tilt.${input.version}.${input.os}.${input.arch}.tar.gz";

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 tilt $out/bin/tilt
      '';

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "x86_64";
          sha256 = "sha256-kBeGM8AQ69SZJ3tkW2sTA0Bq+AETP3eWbHf3XanRJIQ"; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-ldhDok0bTgTjdaRN2ymQhznfKqOkuW4SkSj84Ni6Zso"; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "mac";
          arch = "x86_64";
          sha256 = "sha256-+8T6d1rUfCyNaAEAnDKDxOEk+ZDxI024Bu8LZiaPIwo"; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "mac";
          arch = "arm64";
          sha256 = "sha256-enJWROtEtGY4EbpcFmoWlis0NPFDzmoAuvm9wJIKiQ4"; # aarch64-darwin
        };
      };
    };

    handler = { pkgs, wrap, system }: {
      devShell = wrap.devShell;
      defaultPackage = wrap.downloadBuilder { };
    };
  };
}
