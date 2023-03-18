{
  inputs.pkg.url = github:defn/pkg/0.0.167;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/bufbuild/buf/releases/download/v${input.vendor}/buf-${input.os}-${input.arch}.tar.gz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 buf/bin/buf $out/bin/buf
    '';

    downloads = {
      

      "x86_64-linux" = {
        os = "Linux";
        arch = "x86_64";
        sha256 = "sha256-ObWBJpOOJlp91g/EcWpKQ5MYluYts9accE191j1Yid0="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "Linux";
        arch = "aarch64";
        sha256 = "sha256-kNjKqFtM/xzbbpbuAeP08aEhNb44NP/UHEhvHMAyE+8="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "Darwin";
        arch = "x86_64";
        sha256 = "sha256-GW51kz98Or6/iDX9/XTBW8lTUlySUOe7/5Q+Pbb7DrE="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "Darwin";
        arch = "arm64";
        sha256 = "sha256-9hh7vPBxjaHeOMpjgDjUpwfdWw4RPhqeEQrIoVASUFo="; # aarch64-darwin
      };
    };
  };
}
