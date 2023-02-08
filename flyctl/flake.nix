{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.22?dir=dev;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = config.slug; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      vendor = builtins.readFile ./VENDOR;
      revision = builtins.readFile ./REVISION;
      version = "${vendor}-${revision}";

      url_template = input: "https://github.com/superfly/flyctl/releases/download/v${input.version}/flyctl_${input.version}_${input.os}_${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "Linux";
          arch = "x86_64";
          sha256 = "sha256-6/uCDfDouHs+AZat8mZybLZelXQyD83zTNmXABatU1s="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "Linux";
          arch = "arm64";
          sha256 = "sha256-okgwe5pfsHX+S4F6SI/hZLsopPy2flm2QnvBvY49De0="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "macOS";
          arch = "x86_64";
          sha256 = "sha256-nvjYOUgnCuhOEgmKsC68Hk58bgnTpAAjOoUCHx+Z4kY="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "macOS";
          arch = "arm64";
          sha256 = "sha256-mliXiG2mgITbBSEtGvu/tpc1Hi91wpSuDHi40Jmp5/U="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 flyctl $out/bin/flyctl
      '';
    };

    handler = { pkgs, wrap, system, builders }:
      wrap.genDownloadBuilders { };
  };
}
