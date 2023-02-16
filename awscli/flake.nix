{
  inputs.pkg.url = github:defn/pkg/0.0.146;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input:
      if input.os == "linux" then
        "https://awscli.amazonaws.com/awscli-exe-${input.os}-${input.arch}-${input.vendor}.zip"
      else
        "https://awscli.amazonaws.com/AWSCLIV2-${input.vendor}.pkg";

    installPhase = { src }: ''
      case $src in
        *.zip)
          unzip $src
          mkdir -p $out/bin $out/awscli
          aws/install -i $out/awscli -b $out/bin
          ;;
        *.pkg)
            xar -xf $src
            mkdir -p $out/bin $out/awscli
            cd aws-cli.pkg
            zcat Payload | (cd $out && cpio -i && mkdir awscli/v2 && mv aws-cli awscli/v2/dist && ln -nfs ../awscli/v2/dist/aws ../awscli/v2/dist/aws_completer bin/)
          ;;
      esac 
    '';

    downloads = {
      options = ctx: {
        dontUnpack = true;
        buildInputs = with inputs.pkg.pkgs.legacyPackages.${ctx.system}; [
          unzip
          xar
          cpio
        ];
      };

      "x86_64-linux" = rec {
        os = "linux";
        arch = "x86_64";
        sha256 = "sha256-Q3bP6AL/OaUzMiRxR0RiDVOTSZq1whzZIxvezAF3+os="; # x86_64-linux
      };
      "aarch64-linux" = rec {
        os = "linux";
        arch = "aarch64";
        sha256 = "sha256-TRuSdMjapUfIqrUqdZjxLpdP3bLmf3T/S9IASL27wW4="; # aarch64-linux
      };
      "x86_64-darwin" = rec {
        sha256 = "sha256-aaatUU3cHcQaAk2nxRWmghrtIJIcRFJsKI8pFNhvBI8="; # x86_64-darwin
      };
      "aarch64-darwin" = rec {
        sha256 = "sha256-aaatUU3cHcQaAk2nxRWmghrtIJIcRFJsKI8pFNhvBI8="; # aarch64-darwin
      };
    };
  };
}
