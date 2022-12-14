{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "coder";
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://github.com/coder/coder/releases/download/v${input.version}/coder_${input.version}_${input.os}_${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-aaauYXJrcsNdX+TOwfjBJIJ+ABkKFv4u/Y+OvDwD4gY="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-aaapCS6vQM8G1UAzuA78hi4Sj6hIQQI8TPT6xsXANFE="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "linux"; # coder forget running this on macos
          arch = "amd64";
          sha256 = "sha256-aaasOq0RNvswzGwfZAyiTTU3uaxrhqLJ6Nz6M4kEByA="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "linux";
          arch = "amd64"; # coder not avaialble for darwin arm64
          sha256 = "sha256-aaasOq0RNvswzGwfZAyiTTU3uaxrhqLJ6Nz6M4kEByA="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin $out/lib
        cp coder $out/bin/coder
      '';
    };

    handler = { pkgs, wrap, system }:
      wrap.genDownloadBuilders {
        dontFixup = true;
      };
  };
}
