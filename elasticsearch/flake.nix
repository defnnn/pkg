{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.4?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = {
      slug = "elasticsearch";
      version = "8.5.2";



      url_template = input: "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${input.version}-${input.os}-${input.arch}.tar.gz";

      installPhase = { src }: ''
        rsync -ia elasticsearch*/ $out
        install -m 0755 -d $out $out/data
        echo -e '#!/usr/bin/env bash\ncd $(dirname $BASH_SOURCE)/..; chmod 755 . logs config data' > $out/bin/elasticsearch-fixup
        chmod 755 $out/bin/elasticsearch-fixup
      '';

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "x86_64";
          sha256 = "sha256-6msZUpycXpep54M1K8Qx9pjDi4sOxJE5wleKLVlBz/M=";
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "aarch64";
          sha256 = "sha256-4gY3qkJ8XR+Mcmt2cQSHkaMYvjt5ePHJZwn2yeusXjc=";
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "x86_64";
          sha256 = "sha256-sbdNZXC8x/NJvMLBVU3GJxmSs2JuLk1AKInrqKrgAIc=";
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "aarch64";
          sha256 = "sha256-Li8JfPP3F4g55nLNHeSKsxrY6fhJI+i5f6G/FzIEHbA=";
        };
      };
    };

    handler = { pkgs, wrap, system }: {
      devShell = wrap.devShell;
      defaultPackage = wrap.downloadBuilder {
        buildInputs = [ pkgs.rsync ];
      };
    };
  };
}
