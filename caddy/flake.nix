{
  inputs.pkg.url = github:defn/pkg/0.0.166;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/caddyserver/caddy/releases/download/v${input.vendor}/caddy_${input.vendor}_${input.os}_${input.arch}.tar.gz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 caddy $out/bin/caddy
    '';

    downloads = {
      

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-4sO+CrSMR5AizEPjBiEe5GSaLTfjLAOU6rH0ZD/I6cY="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-VSTFShq5MLp6bZZMO1pbotSr4RHDxSpbTcATAmOfo3c="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "mac";
        arch = "amd64";
        sha256 = "sha256-ErvMpi7YB2W/KlMSsh2ckHKLcnmwHPsRve5snHi3Fts="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "mac";
        arch = "arm64";
        sha256 = "sha256-UdyQ9A1UYVheL0LUpetn+80p4k4YC9wvYwON56OGK7Y="; # aarch64-darwin
      };
    };
  };
}
