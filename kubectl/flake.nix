{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "kubectl";
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://dl.k8s.io/release/v${input.version}/bin/${input.os}/${input.arch}/kubectl";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-fhPzO3N5tsJcOuBV5Dies+7xaOVj83tcXxvmcuRraG4="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-9ZxSLPX524JsZPKDZJRqy2vLaVdmkpH6Kbkmt4ErW74="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-QtEQkAbJ3fAvfKSyvF/6OTtqw5DD8bYEc/DoaoPGPA0="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-zG3RC3FaY489x1Gsoz+lt4v4T4O0Ywf2zSKp8hu8pdw="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 $src $out/bin/kubectl
      '';
    };

    handler = { pkgs, wrap, system }:
      wrap.genDownloadBuilders { dontUnpack = true; };
  };
}
