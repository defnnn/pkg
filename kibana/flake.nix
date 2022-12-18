{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.16?dir=dev;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = config.slug; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://artifacts.elastic.co/downloads/kibana/kibana-${input.version}-${input.os}-${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "x86_64";
          sha256 = "sha256-EoYztEguhJ2S/O03h5CBZHVG+hYAhgQQ5/Skb82rFqo="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "aarch64";
          sha256 = "sha256-OhOt+EPgpUNn1mba8HG5Q5DCU3Od2HrVIzrXj50P6a8="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "x86_64";
          sha256 = "sha256-1WhXb32qw3GqsQQJOBRQyuJ6kZ/HqmE7rGKxHwozgDA="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "aarch64";
          sha256 = "sha256-yUkNua3xANsXxZqPmr2ZLyB81Z/WQXF7b7lIyxfaNB0="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        rsync -ia kibana*/ $out
      '';
    };

    handler = { pkgs, wrap, system, builders }:
      wrap.genDownloadBuilders {
        buildInputs = [ pkgs.rsync ];
      };
  };
}
