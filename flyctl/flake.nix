{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.19?dir=dev;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = config.slug; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      vendor = builtins.readFile ./VENDOR;
      revision = builtins.readFile ./REVISION;
      version = "${vendor}-${revision}";

      url_template = input: "https://github.com/superfly/flyctl/releases/download/v${input.version}/flyctl_${input.version}_${input.os}_${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "Linux";
          arch = "x86_64";
          sha256 = "sha256-7T0B+A4S4MCyqdg1Bhuvvo1GwhpoIVr/Pzw98mMosT8="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "Linux";
          arch = "arm64";
          sha256 = "sha256-R0aTsHj4lKeq0OTAL2Ke5Nf+yM5dHlZ07Rkj+va5pvg="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "macOS";
          arch = "x86_64";
          sha256 = "sha256-6oIbB7iZB+onds/UUTppW89kQpdVVTOXvQp7tg07eBY="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "macOS";
          arch = "arm64";
          sha256 = "sha256-4tLM1cRG5wzqf5nJot3basg2hviad0LoDRBBpZxIaZQ="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 flyctl $out/bin/flyctl
      '';
    };

    handler = { pkgs, wrap, system, builders }:
      wrap.genDownloadBuilders { };
  };
}
