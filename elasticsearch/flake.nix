{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10-rc3?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "elasticsearch";
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${input.version}-${input.os}-${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "x86_64";
          sha256 = "sha256-6msZUpycXpep54M1K8Qx9pjDi4sOxJE5wleKLVlBz/M="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "aarch64";
          sha256 = "sha256-4gY3qkJ8XR+Mcmt2cQSHkaMYvjt5ePHJZwn2yeusXjc="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "x86_64";
          sha256 = "sha256-sbdNZXC8x/NJvMLBVU3GJxmSs2JuLk1AKInrqKrgAIc="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "aarch64";
          sha256 = "sha256-Li8JfPP3F4g55nLNHeSKsxrY6fhJI+i5f6G/FzIEHbA="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        rsync -ia elasticsearch*/ $out
      '';
    };

    handler = { pkgs, wrap, system }:
      wrap.genDownloadBuilders {
        buildInputs = [ pkgs.rsync ];
      };
  };
}
