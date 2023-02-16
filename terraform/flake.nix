{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.22?dir=dev;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = builtins.readFile ./SLUG; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      vendor = builtins.readFile ./VENDOR;
      revision = builtins.readFile ./REVISION;
      version = "${vendor}-${revision}";

      url_template = input: "https://releases.hashicorp.com/terraform/${input.version}/terraform_${input.version}_${input.os}_${input.arch}.zip";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-vHXivBro9ty2P5sl1dB+P4pAbGK4fDaWceRHYKxzkiA="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-RBC67ayDONVgyQ2n7ikSjnq8Zrhoo5KntYbzX0H7ViQ="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-2nDLx0I2sfsCpCymtFnhKlTtKKk78AbaG/kNakV7iXc="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-W85iuoqXI8dRceAQ8TNkOKFmVqsG2Pbw0bo7PUC3C5g="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        unzip $src
        install -m 0755 terraform $out/bin/terraform
      '';
    };

    handler = { pkgs, wrap, system, builders }:
      wrap.genDownloadBuilders {
        dontUnpack = true;
        dontFixup = true;
        buildInputs = [ pkgs.unzip ];
      };
  };
}
