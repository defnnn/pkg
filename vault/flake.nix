{
  inputs.pkg.url = github:defn/pkg/0.0.169;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://releases.hashicorp.com/vault/${input.vendor}/vault_${input.vendor}_${input.os}_${input.arch}.zip";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      unzip $src
      install -m 0755 vault $out/bin/vault
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
        sha256 = "sha256-acHObdODuzQsT4YaUakUE+sF4TJBWeQ5VTLkKopZr50="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-MjT5iWeNUQ9U4MogyT4EWpsahuM3sJ8pYuVzuByanr8="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-DiV66jPdfgwMuS9SmcMtY1JOu+Ftm1Ha6YDgPZlyYCk="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-PTSZ43F2Rqao1QzlLHNO3GCRXzp2jrdLyqUb+UXGa8I="; # aarch64-darwin
      };
    };
  };
}
