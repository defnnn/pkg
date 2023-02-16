{
  inputs.pkg.url = github:defn/pkg/0.0.141;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/babashka/babashka/releases/download/v${input.vendor}/babashka-${input.vendor}-${input.os}-${input.arch}.tar.gz";

    installPhase = { src }: ''
      install -m 0755 -d $out $out/bin
      ls -ltrhd *
      install -m 0755 bb $out/bin/bb
    '';

    downloads = {
      options = { };

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-+GEVDnA3dPk5H0z2fZgXtRRosCEqCKNV7dDVHmQqctI="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "aarch64";
        sha256 = "sha256-KUGK/IAAxu0viX28Dysng2FxvrgAxmbT382R1ljcgY4="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "macos";
        arch = "amd64";
        sha256 = "sha256-bJVXnCaJvMxvyJ6aBH8gfwdrHCieunZUvFBHAcHLW3s="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "macos";
        arch = "aarch64";
        sha256 = "sha256-eSrehuYXAxcPPeMIIYMXPbZqmpixHQHJWs4CNfCl40U="; # aarch64-darwin
      };
    };
  };
}
