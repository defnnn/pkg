{
  inputs = {
    dev.url = github:defn/pkg?dir=dev&ref=dev-0.0.1;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "argocd";
      version = "2.5.2";
      homepage = "https://github.com/defn/pkg/tree/master/${slug}";
      description = "${slug}";

      url_template = input: "https://github.com/argoproj/argo-cd/releases/download/v${input.version}/argocd-${input.os}-${input.arch}";

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 $src $out/bin/argocd
      '';

      downloads = {
        "x86_64-linux" = rec {
          inherit version;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-JJp0CejWAjR2aEIKxMssgoVl/nLRub/7Brv3yBbsOMY";
        };
        "aarch64-linux" = rec {
          inherit version;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-BR7rM9DVmQMZiRCgfWQUeEF/q30/l6gxaOdTS3xmILQ";
        };
        "x86_64-darwin" = rec {
          inherit version;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-riQbBiVJnZlSs2tbQ6ulxf4jpsT8qPpEOGiDViD6vO4";
        };
        "aarch64-darwin" = rec {
          inherit version;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-1gOBzg0CFeKi0ip6AdLxpbz2eo9MnLelW4/G+0hA4Aw";
        };
      };
    };

    handler = { pkgs, wrap, system }: rec {
      devShell = wrap.devShell;
      defaultPackage = wrap.downloadBuilder { dontUnpack = true; };
    };
  };
}
