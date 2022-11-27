{
  inputs = {
    dev.url = github:defn/pkg?dir=dev&ref=dev-0.0.1;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "helm";
      version = "3.10.2";
      homepage = "https://github.com/defn/pkg/tree/master/${slug}";
      description = "${slug}";

      url_template = input: "https://get.helm.sh/helm-v${input.version}-${input.os}-${input.arch}.tar.gz";

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 */helm $out/bin/helm
      '';

      downloads = {
        "x86_64-linux" = rec {
          inherit version;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-IxWUGhMpHCd9rJ9l516tVjhkQNOQfgVAvxV65w8Yg0c";
        };
        "aarch64-linux" = rec {
          inherit version;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-V/oXtrsECjeIEWVXpyV58hgOqWILTuiptyROWQHfAuQ";
        };
        "x86_64-darwin" = rec {
          inherit version;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-6ImWDkwdfi39uRsQK+z68icAy4bcPjVT2b69e6taOAM";
        };
        "aarch64-darwin" = rec {
          inherit version;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-RgRB7qF2TKQ44p+g44qg0mB0AvdTy2VqSrDakiPtpJQ";
        };
      };
    };

    handler = { pkgs, wrap, system }: rec {
      devShell = wrap.devShell;
      defaultPackage = wrap.downloadBuilder { };
    };
  };
}
