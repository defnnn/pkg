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
        sha256 = "sha256-4HYCL6FPxF3oL248hj/we3MZJY1hx0EI4zmwb5NDXLM="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-cNRN1j2n8CS66o8DovmzmzmxKHZJpsIKpJIDXoEFoU0="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-EDQ6VttQluTFlTHjD1IYHDMiYzYRFub3QTvpj51NV0I="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-TdSyzvOPpXPXs1cOLuubPq8zSVO9pg+VXyHr36z42OA="; # aarch64-darwin
      };
    };
  };
}
