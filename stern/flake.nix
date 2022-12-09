{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "stern";
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://github.com/stern/stern/releases/download/v${input.version}/stern_${input.version}_${input.os}_${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-bv8CjRBLU8ilPDr3UqUikt2yAktGnOWrBa7i8JVL3nI"; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-NHRsWLgOjw2zJz/2kaA9XFfxCpE+nGp5H64fQQeu5eU"; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-Pi0G7zWGaxVaqTSdGzN67RFOVtSdf8gkUUPWGAEV/+8"; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-Bm4FYrlirPV2JC6aI6pNYd4hgS1fpiy/4ZimL1gB0oI"; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 stern $out/bin/stern
      '';
    };

    handler = { pkgs, wrap, system }:
      wrap.genDownloadBuilders { };
  };
}
