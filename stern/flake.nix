{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.4?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = {
      slug = "stern";
      version = "1.22.0";



      url_template = input: "https://github.com/stern/stern/releases/download/v${input.version}/stern_${input.version}_${input.os}_${input.arch}.tar.gz";

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 stern $out/bin/stern
      '';

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-bv8CjRBLU8ilPDr3UqUikt2yAktGnOWrBa7i8JVL3nI";
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-NHRsWLgOjw2zJz/2kaA9XFfxCpE+nGp5H64fQQeu5eU";
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-Pi0G7zWGaxVaqTSdGzN67RFOVtSdf8gkUUPWGAEV/+8";
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-Bm4FYrlirPV2JC6aI6pNYd4hgS1fpiy/4ZimL1gB0oI";
        };
      };
    };

    handler = { pkgs, wrap, system }: {
      devShell = wrap.devShell;
      defaultPackage = wrap.downloadBuilder { };
    };
  };
}
