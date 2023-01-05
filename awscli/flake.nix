{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.22?dir=dev;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = config.slug; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      vendor = builtins.readFile ./VENDOR;
      revision = builtins.readFile ./REVISION;
      version = "${vendor}-${revision}";

      url_template = input: "https://awscli.amazonaws.com/awscli-exe-${input.os}-${input.arch}-${input.version}.zip";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "x86_64";
          sha256 = "sha256-fuR18iwbNcyeU6/7+Wqf/OkXBuFUqUQdDTnL+DZrcY4="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "aarch64";
          sha256 = "sha256-Yk67BHBdSQnrDVbUZ/5ri1xTqMWTde1SDnAjYSASUHc="; # aarch64-linux
        };
      };

      installPhase = { src }: ''
        unzip $src
        mkdir -p $out/bin $out/awscli
        aws/install -i $out/awscli -b $out/bin
      '';
    };

    handler = { pkgs, wrap, system, builders }:
      wrap.genDownloadBuilders {
        dontUnpack = true;
        buildInputs = [ pkgs.unzip ];
      };
  };
}
