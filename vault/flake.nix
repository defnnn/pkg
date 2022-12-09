{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.5?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "vault";
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://releases.hashicorp.com/vault/${input.version}/vault_${input.version}_${input.os}_${input.arch}.zip";

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        unzip $src
        install -m 0755 vault $out/bin/vault
      '';

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-EWwUPeN3p3p+pFWjZ9Xp/lKQRY6KlBpuLdhdkqrtumc="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-ezXRJRhynP4+/iAHoHhik0sKbfBTFG6hUkP4nmsL+/I="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-dtmFxColS/FvpV+/OQkqNOJ6uiKULC+CmmzoGsX9xA8="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-8fpCCFjrhnRBaiKFy0j5iHxoDrNDcjXMBsaaMBeN5wg="; # aarch64-darwin
        };
      };
    };

    handler = { pkgs, wrap, system }: {
      devShell = wrap.devShell;
      defaultPackage = wrap.downloadBuilder {
        dontUnpack = true;
        dontFixup = true;
        buildInputs = [ pkgs.unzip ];
      };
    };
  };
}
