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

      url_template = input: "https://github.com/babashka/babashka/releases/download/v${input.version}/babashka-${input.version}-${input.os}-${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-+GEVDnA3dPk5H0z2fZgXtRRosCEqCKNV7dDVHmQqctI="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "aarch64";
          sha256 = "sha256-KUGK/IAAxu0viX28Dysng2FxvrgAxmbT382R1ljcgY4="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "macos";
          arch = "amd64";
          sha256 = "sha256-bJVXnCaJvMxvyJ6aBH8gfwdrHCieunZUvFBHAcHLW3s="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "macos";
          arch = "aarch64";
          sha256 = "sha256-eSrehuYXAxcPPeMIIYMXPbZqmpixHQHJWs4CNfCl40U="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        ls -ltrhd *
        install -m 0755 bb $out/bin/bb
      '';
    };

    handler = { pkgs, wrap, system, builders }:
      wrap.genDownloadBuilders { };
  };
}
