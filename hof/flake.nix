{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "hof";
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://github.com/hofstadter-io/hof/releases/download/v${input.version}/hof_${input.version}_${input.os}_${input.arch}";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "Linux";
          arch = "x86_64";
          sha256 = "sha256-9ETOkA8WYQNEIzDzGnuRoNtS57HFwgyyssKIwjRHuEU="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "Linux";
          arch = "arm64";
          sha256 = "sha256-c6opqw2Gjl5icjjTorblJKQRI8qAJAS+hQ3H9vUKlWE="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "Darwin";
          arch = "x86_64";
          sha256 = "sha256-S0C0spCHPTzSjK8EUQIo0FmjS66lTTyXiSgrjTFOwEo="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-JtXaTqFNpv5F7hUykVlNjRZef6k8JppWfFLy+QPNpbE="; # x86_64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 $src $out/bin/hof
      '';
    };

    handler = { pkgs, wrap, system }:
      wrap.genDownloadBuilders { dontUnpack = true; };
  };
}
