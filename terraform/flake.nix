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
          sha256 = "sha256-nZ59aptBzvi4N69ohEHU+72EtQPSQGHQeK1mJEHHAkA="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-pCvzx9Yyf0XSshK2kqtCKShftE27itt8OeGL4rJhZ8g="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-PLKflZYpR7Db3z+DM4Ehh5Qm1yO6YAB+fCZMPIoq3Y8="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-RUeke+CDUKPrbkT9KOlXz1FcOitS4E8TQ2agix+/A+w="; # aarch64-darwin
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
