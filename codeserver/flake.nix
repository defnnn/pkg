{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "code-server";
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://github.com/coder/code-server/releases/download/v${input.version}/code-server-${input.version}-${input.os}-${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-LceuYXJrcsNdX+TOwfjBJIJ+ABkKFv4u/Y+OvDwD4gY="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-prCpCS6vQM8G1UAzuA78hi4Sj6hIQQI8TPT6xsXANFE="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "macos";
          arch = "amd64";
          sha256 = "sha256-w/esOq0RNvswzGwfZAyiTTU3uaxrhqLJ6Nz6M4kEByA="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "macos";
          arch = "arm64";
          sha256 = "sha256-w/esOq0RNvswzGwfZAyiTTU3uaxrhqLJ6Nz6M4kEByA="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin $out/lib
        rsync -ia . $out/lib/.
        mv -f $out/lib/code-server-${vendor}-*  $out/lib/code-server-${vendor}
        ln -fs $out/lib/code-server-${vendor}/bin/code-server $out/bin/code-server
      '';
    };

    handler = { pkgs, wrap, system }:
      wrap.genDownloadBuilders {
        dontFixup = true;
        buildInputs = with pkgs; [ rsync ];
      };
  };
}
