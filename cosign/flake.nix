{
  inputs.pkg.url = github:defn/pkg/0.0.179;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/sigstore/cosign/releases/download/v${input.vendor}/cosign-${input.os}-${input.arch}";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 $src $out/bin/cosign
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
        sha256 = "sha256-FppTWUxDfVP/xAG5EbfnDUU/Wiwflusqc2809jVsTys="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-gTLLL7maTGC6jgOweeEkYsJwcwKKXQjAfs2mcoTgyI0="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-0sj8DttCoel0XaHEOikozuBE87ihuN9kCIo4TH5vW10="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-nXgh4cBdpLB1E3KcsA0QcMmpUzLGbZD6WT7XfYxyyio="; # aarch64-darwin
      };
    };
  };
}
