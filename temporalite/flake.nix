{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10-rc3?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "temporalite";
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://github.com/temporalio/temporalite/releases/download/v${input.version}/temporalite_${input.version}_${input.os}_${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-aaaoHTov0j6FXnlrct3Nw9dhht8N76wHIrpYOBCNx9c="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-aaaZ0K9jrc4LVXNzEtsNEHlKmefoz4WSundqcelHiNc="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-xTLdDBREMrM/lTGVYRzZXuYSo9m2lRzt/zninQ+1wVY="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-aaaBR62Y3jJdkT08dY277/RE6GZ85NiXWrt208XuwFo="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 temporalite $out/bin/temporalite
      '';
    };

    handler = { pkgs, wrap, system }: 
      wrap.genDownloadBuilders { };
  };
}
