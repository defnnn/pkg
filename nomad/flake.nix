{
  inputs.pkg.url = github:defn/pkg/0.0.159;
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
        sha256 = "sha256-Y7u0wdfD2npo3R4+7TAaTt7PCTCyxe/klAIA7Zxz41A="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-wNcsiQ3neDBmJWh13I7FlXwzEZ8OU/EtPJg4Cvdevcw="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-octuQTyy6Y3nTeYvaVzjY9OqmYdCvM15Se5Fhexe+HM="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-sFL2RPyV2ExUOvCnw8om0m62qaoc7NI2U1tsPENO1lg="; # aarch64-darwin
      };
    };
  };
}
