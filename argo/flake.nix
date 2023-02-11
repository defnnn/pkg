{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.22?dir=dev;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = builtins.readFile ./SLUG; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      vendor = builtins.readFile ./VENDOR;
      revision = builtins.readFile ./REVISION;
      version = "${vendor}-${revision}";

      url_template = input: "https://github.com/argoproj/argo-workflows/releases/download/v${input.version}/argo-${input.os}-${input.arch}.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-BSj/DAqoej8VA3bu4vGybotB65ZXjEPXFckGMEYn06E="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-bZU/Zn3tZo81G/65TzLjS3C63CN3DBG1Xj0rwyyqJ0w="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-l1YmcpBh4EewMcZmd52S+T9K7klWYT2taJMLDKWm5Ik="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-yYz3/hcQ393EbuHUQSet1fBV01jQTBf7BACT5e9JjCw="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        cat $src | gunzip > argo
        install -m 0755 -d $out $out/bin
        install -m 0755 argo $out/bin/argo
      '';
    };

    handler = { pkgs, wrap, system, builders }:
      wrap.genDownloadBuilders { dontUnpack = true; };
  };
}
