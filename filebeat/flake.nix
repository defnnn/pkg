{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.4?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "filebeat";
      version = "8.5.2";



      url_template = input: "https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${input.version}-${input.os}-${input.arch}.tar.gz";

      installPhase = { src }: ''
        rsync -ia filebeat*/ $out
        install -m 0755 -d $out $out/bin
        install -m 0755 -d $out $out/data
        install -m 0755 -d $out $out/logs
        mv $out/filebeat $out/bin/filebeat
        echo -e '#!/usr/bin/env bash\ncd $(dirname $BASH_SOURCE)/..; chmod 755 . logs data logs' > $out/bin/filebeat-fixup
        chmod 755 $out/bin/filebeat-fixup
      '';

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "x86_64";
          sha256 = "sha256-20g42xKyHVVmjuMz4EV7DtSX7ca8CMCwzMqnXwQFDnw=";
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-EWqvtkzUUt1q+54C4dJTdzB1kbEIuPp5l/TbPXq/E3s=";
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "x86_64";
          sha256 = "sha256-01zGv1h6rYcHedacffkPW0UmuwHDGnyVPs+3vPdcYd0=";
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "aarch64";
          sha256 = "sha256-UuyU/TVRhPO7+1p8NOj5STrNx+tQmAgSejww8+mVaZg=";
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
