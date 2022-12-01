{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.4?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = {
      slug = "kibana";
      version = "8.5.2";



      url_template = input: "https://artifacts.elastic.co/downloads/kibana/kibana-${input.version}-${input.os}-${input.arch}.tar.gz";

      installPhase = { src }: ''
        rsync -ia kibana*/ $out
        install -m 0755 -d $out $out/data
        echo -e '#!/usr/bin/env bash\ncd $(dirname $BASH_SOURCE)/..; chmod 755 . logs config data' > $out/bin/kibana-fixup
        chmod 755 $out/bin/kibana-fixup
      '';

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "x86_64";
          sha256 = "sha256-EoYztEguhJ2S/O03h5CBZHVG+hYAhgQQ5/Skb82rFqo=";
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "aarch64";
          sha256 = "sha256-OhOt+EPgpUNn1mba8HG5Q5DCU3Od2HrVIzrXj50P6a8=";
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "x86_64";
          sha256 = "sha256-1WhXb32qw3GqsQQJOBRQyuJ6kZ/HqmE7rGKxHwozgDA=";
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "aarch64";
          sha256 = "sha256-yUkNua3xANsXxZqPmr2ZLyB81Z/WQXF7b7lIyxfaNB0=";
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
