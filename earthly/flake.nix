{
  inputs = {
    dev.url = github:defn/pkg?dir=dev&ref=v0.0.62;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "earthly";
      version = "0.6.30";
      homepage = "https://github.com/defn/pkg/tree/master/${slug}";
      description = "${slug}";

      url_template = input: "https://github.com/earthly/earthly/releases/download/v${input.version}/earthly-${input.os}-${input.arch}";

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 $src $out/bin/earthly
      '';

      downloads = {
        "x86_64-linux" = rec {
          inherit version;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-3jpDPUXOFcHVYwZobOqIIa4guOg/UAviYjgfmlL7Z6k=";
        };
        "aarch64-linux" = rec {
          inherit version;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-xUbCZUamR9rfQENT64qJZqqPGd7JJO921XzmY0l3G6Q=";
        };
        "x86_64-darwin" = rec {
          inherit version;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-K1LJVGyxXb9gzJTVobSuyoMNIR+uRVLiWg/oiMkU9qc=";
        };
        "aarch64-darwin" = rec {
          inherit version;
          os = "darwin";
          arch = "x86_64";
          sha256 = " sha256-K1LJVGyxXb9gzJTVobSuyoMNIR+uRVLiWg/oiMkU9qc=";
        };
      };
    };

    handler = { pkgs, wrap, system }: rec {
      devShell = wrap.devShell;
      defaultPackage = wrap.downloadBuilder { dontUnpack = true; };
    };
  };
}
