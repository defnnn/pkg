{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10-rc3?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "flyctl";
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://github.com/superfly/flyctl/releases/download/v${input.version}/flyctl_${input.version}_${input.os}_${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "Linux";
          arch = "x86_64";
          sha256 = "sha256-LYSab3g9ia6B0aJQ1FRSNYGjE+YBdeOF9S6SxgtMxAY="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "Linux";
          arch = "arm64";
          sha256 = "sha256-O+O7A7wDr5wgampeNd0GnGLGNKoQNvf0niJPro6EHoo="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "macOS";
          arch = "x86_64";
          sha256 = "sha256-8IjFuy51ad4ukocxwFb9CRYveWzZj9snuXWE6XcrRHs="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "macOS";
          arch = "arm64";
          sha256 = "sha256-ptq2olmEqv7epVeviTyqJ0jmnti4wIAbPyEp8OQwADQ="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 flyctl $out/bin/flyctl
      '';
    };

    handler = { pkgs, wrap, system }:
      wrap.genDownloadBuilders { };
  };
}
