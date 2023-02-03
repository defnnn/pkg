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
          sha256 = "sha256-njkbbuMHTzRa9TEuMDTFZE776pprDDN8KRdMjns+TWM="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "Linux";
          arch = "arm64";
          sha256 = "sha256-NTmcDEwzc4P5bby74T62ZZgNnHTbs6Z9/lSsz5fSIgU="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "macOS";
          arch = "x86_64";
          sha256 = "sha256-SGU6iSOc+DBjkpYDw7pAVy+6SfkWDWQqsu2mlDT5A9E="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "macOS";
          arch = "arm64";
          sha256 = "sha256-EiIjLWse52I+ts3l6wCLJWmORV6dFX6ae298z+uZEXQ="; # aarch64-darwin
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
