{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10-rc3?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "kubectl";
      version = "1.24.8";



      url_template = input: "https://dl.k8s.io/release/v${input.version}/bin/${input.os}/${input.arch}/kubectl";

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 $src $out/bin/kubectl
      '';

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-+TwYdR7HFbTUQ35+zhj+kZSMcb4fJKsCot3hUPVEmFU"; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-uKwqv8sfoEaV0YCYVY/0g+wsJIiHe1q8QDWlQ1RM3LE"; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-fSpFWqnWvgVBxcUWogNLuFAHt75rxeS8GkU82eQVMKk"; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-raAuw+vpg1iyfF9qTwa9qlR0cIfhqiqO2xP96lRiUMM"; # aarch64-darwin
        };
      };
    };

    handler = { pkgs, wrap, system }: {
      devShell = wrap.devShell;
      defaultPackage = wrap.downloadBuilder { dontUnpack = true; };
    };
  };
}
