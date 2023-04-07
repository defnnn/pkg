{
  inputs.pkg.url = github:defn/pkg/0.0.199;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/gruntwork-io/cloud-nuke/releases/download/v${input.vendor}/cloud-nuke_${input.os}_${input.arch}";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 $src $out/bin/cloud-nuke
    '';

    downloads = {
      options = pkg: {
        dontUnpack = true;
        dontFixup = true;
      };

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-zAdru2ipPp8bXCYT6f0X8i4ADdg9nHCRF/sYjyNAYOo="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-zpQwt70vj3y9ajz76kwkcaHB4ZD2bsMxd3z2i8JtFmg="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-VY4YpaRemfd9WMSeAaceo6LUBZqb1uWTHyTOBtqML1c="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-USaUy4ZSorhjjMznggdnFh9fQvggTu8aBF1k63jGhU0="; # aarch64-darwin
      };
    };
  };
}
