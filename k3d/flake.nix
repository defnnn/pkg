{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "k3d";
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://github.com/k3d-io/k3d/releases/download/v${input.version}/k3d-${input.os}-${input.arch}";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-gHXUDHTJfSZC8V9TXLSNbW6C3xQ/UogzoZPYfKrGoXY"; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-NtuX37P1tWx80EiSTYer+l9JnGL1JOAOJQD+dfiAVq4"; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-EGP3dHSJ2/aZB6f5sOc3KbhfgvQxDz2KQKRQSkF0ciQ"; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-SGuqGVFXGD+24yt4HdCmOPZi7V+cTYBRAofOljCoAIE"; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 $src $out/bin/k3d
      '';
    };

    handler = { pkgs, wrap, system }:
      wrap.genDownloadBuilders { dontUnpack = true; };
  };
}
