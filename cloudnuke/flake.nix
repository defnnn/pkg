{
  inputs.pkg.url = github:defn/pkg/0.0.205;
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
        sha256 = "sha256-vqzS+iZoS/OADf5sm2EIhVG/s/kDdNCG5g5t2D4XooU="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-C6WhTNbmaaJMc69WQd/oyX9fhgkegLKMRj2rxKOgqdc="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-aweqYDBbi3FcwaT6uH/4pCAah/pgn/gew5AE65i/ESs="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-+hL+4Q0VOY8CobMsDtWRy1ktTdTG1AWdezkGLwYPbbU="; # aarch64-darwin
      };
    };
  };
}
