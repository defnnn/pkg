{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.4?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = {
      slug = "k3d";
      version = "5.4.6";



      url_template = input: "https://github.com/k3d-io/k3d/releases/download/v${input.version}/k3d-${input.os}-${input.arch}";

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 $src $out/bin/k3d
      '';

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-gHXUDHTJfSZC8V9TXLSNbW6C3xQ/UogzoZPYfKrGoXY";
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-NtuX37P1tWx80EiSTYer+l9JnGL1JOAOJQD+dfiAVq4";
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-EGP3dHSJ2/aZB6f5sOc3KbhfgvQxDz2KQKRQSkF0ciQ";
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-SGuqGVFXGD+24yt4HdCmOPZi7V+cTYBRAofOljCoAIE";
        };
      };
    };

    handler = { pkgs, wrap, system }: {
      devShell = wrap.devShell;
      defaultPackage = wrap.downloadBuilder { dontUnpack = true; };
    };
  };
}
