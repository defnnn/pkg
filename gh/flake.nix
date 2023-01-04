{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.21?dir=dev;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = config.slug; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      vendor = builtins.readFile ./VENDOR;
      revision = builtins.readFile ./REVISION;
      version = "${vendor}-${revision}";

      url_template = input: "https://github.com/cli/cli/releases/download/v${input.version}/gh_${input.version}_${input.os}_${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-az5W7jJTeV2cSOAZz9e438A7KAc6QR0fUn9QIXZPY8s="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-aaaH+UwH1GgPunhxN/0TVO6fljNmpxLl1xiqJM2Pm9M="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "macos";
          arch = "amd64";
          sha256 = "sha256-aaaDfGGOhlEHwZftWBwymB0/hnjyMVJfDr3Fli0pFL4="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "macos";
          arch = "amd64"; # no arm64 macos
          sha256 = "sha256-aaaDfGGOhlEHwZftWBwymB0/hnjyMVJfDr3Fli0pFL4="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 */bin/gh $out/bin/gh
      '';
    };

    handler = { pkgs, wrap, system, builders }:
      wrap.genDownloadBuilders { };
  };
}
