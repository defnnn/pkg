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

      url_template = input: "${input.url}";

      downloads = {
        "x86_64-linux" = rec {
          version = vendor;
          os = "linux";
          arch = "x86_64";
          url = "https://awscli.amazonaws.com/awscli-exe-${os}-${arch}-${version}.zip";
          sha256 = "sha256-fuR18iwbNcyeU6/7+Wqf/OkXBuFUqUQdDTnL+DZrcY4="; # x86_64-linux
        };
        "aarch64-linux" = rec {
          version = vendor;
          os = "linux";
          arch = "aarch64";
          sha256 = "sha256-Yk67BHBdSQnrDVbUZ/5ri1xTqMWTde1SDnAjYSASUHc="; # aarch64-linux
          url = "https://awscli.amazonaws.com/awscli-exe-${os}-${arch}-${version}.zip";
        };
        "x86_64-darwin" = rec {
          version = vendor;
          sha256 = "sha256-Yaa7BHBdSQnrDVbUZ/5ri1xTqMWTde1SDnAjYSASUHc="; # aarch64-linux
          url = "https://awscli.amazonaws.com/AWSCLIV2-${version}.pkg";
        };
        "aarch64-darwin" = rec {
          version = vendor;
          sha256 = "sha256-YkaaBHBdSQnrDVbUZ/5ri1xTqMWTde1SDnAjYSASUHc="; # aarch64-linux
          url = "https://awscli.amazonaws.com/AWSCLIV2-${version}.pkg";
        };
      };

      installPhase = { src }: ''
        case $src in
          *.zip)
            unzip $src
            mkdir -p $out/bin $out/awscli
            aws/install -i $out/awscli -b $out/bin
            ;;
          *.pkg)
              xar -xf $src
              cd Installer.pkg
              zcat Payload | (cd $out && cpio -i && mv usr/local/aws-cli awscli/v2 && ln -nfs ../awscli/v2/dist/aws bin/aws && ln -nfs ../awscli/v2/dist/aws_completer bin/aws_completer)
            ;;
        esac 
      '';
    };

    handler = { pkgs, wrap, system, builders }:
      wrap.genDownloadBuilders {
        dontUnpack = true;
        buildInputs = with pkgs; [
          unzip
          xar
          cpio
        ];
      };
  };
}
