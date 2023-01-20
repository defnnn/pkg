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

      url_template = input: "https://github.com/tilt-dev/tilt/releases/download/v${input.version}/tilt.${input.version}.${input.os}.${input.arch}.tar.gz";
      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "x86_64";
          sha256 = "sha256-aaard6LIIOTpNyM3sZnC4bRVp8IcFrHIXNQ89/iOcVM="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-aaaS+8Aaqclog7wGnYrkqFyEsAVtec+km6LlwCj7PfM="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "mac";
          arch = "x86_64";
          sha256 = "sha256-/KXvW7kIb/l0oGG84bSEJo7nJQiigM2xfmShwdd7WQE="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "mac";
          arch = "arm64";
          sha256 = "sha256-aaau6vQgbVd6zsqVnCpih7IZUx89677DIqYAOXeofFk="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 tilt $out/bin/tilt
      '';

    };

    handler = { pkgs, wrap, system, builders }:
      wrap.genDownloadBuilders { };
  };
}
