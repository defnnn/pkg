{
  inputs.pkg.url = github:defn/pkg/0.0.172;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://releases.hashicorp.com/terraform/${input.vendor}/terraform_${input.vendor}_${input.os}_${input.arch}.zip";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      unzip $src
      install -m 0755 terraform $out/bin/terraform
    '';

    downloads = {
      options = pkg: {
        dontUnpack = true;
        dontFixup = true;
        buildInputs = with pkg.ctx.pkgs; [ unzip ];
      };

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-nzyjPQT1M1Rygp0d93hRFbYBdtYQrm8VgzQ7CiIhqTE="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-OcGCZwxOY+kY4KFggLHMR7sW4VjX2pYzPWgtapy465E="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-whimwO9mkrJa8WmVyMe99nOeljj++SNcas7TzYSvr2Y="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-r4/3V2yPxBSW/fl+kZmwDY2BcppqDoIer039CKp2NUA="; # aarch64-darwin
      };
    };
  };
}
