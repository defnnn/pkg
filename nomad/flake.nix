{
  inputs.pkg.url = github:defn/pkg/0.0.180;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://releases.hashicorp.com/nomad/${input.vendor}/nomad_${input.vendor}_${input.os}_${input.arch}.zip";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      unzip $src
      install -m 0755 nomad $out/bin/nomad
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
        sha256 = "sha256-UdDs8j9HQNB4KH6u8vTanzQgsIeQfTNIDvLsSWKNZGE="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-KHK10x1tP6X6QlPyV2cXFQEYhwJ83zvT3ml8S/tvPnc="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-XtoSoY/L4nfgo3MPQLayXd+piegYB5ThSOTeL01BTj8="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-0HoxFGNySQ54kdvyklDZcVDOJvN47/5UmMba7bC7kBQ="; # aarch64-darwin
      };
    };
  };
}
