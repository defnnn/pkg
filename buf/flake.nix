{
  inputs.pkg.url = github:defn/pkg/0.0.193;
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
        sha256 = "sha256-/oWf+sq0gabuYvfQQln9S8wRDdSMsmGC6jXTeiVteBk="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "Linux";
        arch = "aarch64";
        sha256 = "sha256-lOaYJamea34CcIgniQFAgO5RGv2Iup8e6CwD9kjGaHI="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "Darwin";
        arch = "x86_64";
        sha256 = "sha256-L8u2cig/HfQON+a+Qb690fZvDP8rM7/4tYe1jg2GQ3k="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "Darwin";
        arch = "arm64";
        sha256 = "sha256-pief0mmUMOccWAnJhTv4KhBU/3ZrdS5fiCzS4RwKJg4="; # aarch64-darwin
      };
    };
  };
}
