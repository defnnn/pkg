{
  inputs = {
    dev.url = github:defn/pkg?dir=dev&ref=v0.0.54;
  };

  outputs = inputs:
    inputs.dev.main {
      inherit inputs;

      config = rec {
        slug = "defn-pkg-caddy";
        version = "2.6.2";
        homepage = "https://defn.sh/${slug}";
        description = "caddy";

        url_template = input: "https://github.com/caddyserver/caddy/releases/download/v${input.version}/caddy_${input.version}_${input.os}_${input.arch}.tar.gz";

        downloads = {
          "x86_64-linux" = rec {
            inherit version;
            os = "linux";
            arch = "amd64";
            sha256 = "sha256-WvDuZaAiAQi3uWMisEGKvNpSbV9/7Fr66gKfGuvMpio=";
          };
          "aarch64-linux" = rec {
            inherit version;
            os = "linux";
            arch = "arm64";
            sha256 = "sha256-DZvYw67zsu1tc7/Tn6kIxGrjlEsvY5nGqJV8RWCbM84=";
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

        installPhase = { src }: ''
          install -m 0755 -d $out $out/bin
          install -m 0755 caddy $out/bin/caddy
        '';
      };

      handler = { pkgs, wrap, system }:
        rec {
          devShell = wrap.devShell;
          defaultPackage = wrap.downloadBuilder { };
        };
    };
}
