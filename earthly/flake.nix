{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.22?dir=dev;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = config.slug; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      revision = builtins.readFile ./REVISION;
      vendor = builtins.readFile ./VENDOR;
      version = "${slug}-${vendor}";

      url_template = input: "https://github.com/earthly/earthly/releases/download/v${input.version}/earthly-${input.os}-${input.arch}";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-M05JbIywoB/kVfPc3bZO9ieAQxLZjNHyjZEOIwIOx3k="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-5I4NX0isWQeXqvFl6UaHVFLRDLR/CMuUb1tWvQciRHY="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-My8xfogZrj9ktDv2qUSKw0sz+ZlSdjrbItlCYZJ9zYk="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-kG3g++Wqyw0VqM9rKTym8iLcxwdiHV/tjxQvnEFvr0U="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 $src $out/bin/earthly
      '';
    };

    handler = { pkgs, wrap, system, builders }:
      wrap.genDownloadBuilders { dontUnpack = true; };
  };
}
