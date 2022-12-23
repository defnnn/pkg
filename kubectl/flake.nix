{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.18?dir=dev;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = config.slug; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      vendor = builtins.readFile ./VENDOR;
      revision = builtins.readFile ./REVISION;
      version = "${slug}-${vendor}-${revision}";

      url_template = input: "https://dl.k8s.io/release/v${input.version}/bin/${input.os}/${input.arch}/kubectl";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-amYM1E2z1L/hVj9micvi/7KO5LrzUy4E//LXuQkIHCk="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-e8ZQ8opbRDbfKrz65ZBeRhcoukFhRr6sF6JjT6gqbwo="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-0tY+AJaxTiwVC9ihpQlkqhuRfJhCP2/Lk7Y+TKPSJxo="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-ZtOUgg4ny/CwDn8b2lAmf0p/TKAaQkS7InpcmOUKFLc="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 $src $out/bin/kubectl
      '';
    };

    handler = { pkgs, wrap, system, builders }:
      wrap.genDownloadBuilders { dontUnpack = true; };
  };
}
