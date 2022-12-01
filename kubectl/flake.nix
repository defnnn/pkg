{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.4?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = {
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
          sha256 = "sha256-+TwYdR7HFbTUQ35+zhj+kZSMcb4fJKsCot3hUPVEmFU";
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-uKwqv8sfoEaV0YCYVY/0g+wsJIiHe1q8QDWlQ1RM3LE";
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-fSpFWqnWvgVBxcUWogNLuFAHt75rxeS8GkU82eQVMKk";
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-raAuw+vpg1iyfF9qTwa9qlR0cIfhqiqO2xP96lRiUMM";
        };
      };
    };

    handler = { pkgs, wrap, system }: {
      devShell = wrap.devShell;
      defaultPackage = wrap.downloadBuilder { dontUnpack = true; };
    };
  };
}
