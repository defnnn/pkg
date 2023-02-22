{
  inputs.pkg.url = github:defn/pkg/0.0.166;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/smallstep/cli/releases/download/v${input.vendor}/step_${input.os}_${input.vendor}_${input.arch}.tar.gz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 */bin/step $out/bin/step
    '';

    downloads = {
      

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-BE/lUX7OkH3ZGT6SuhV5kmMQ4GlOg/6Ue0KOJP8Il4U="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-FrRDsnR69U9BtIKpiiRczG1A9fbRBeNsMZApIAmoNyA="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-p4PZAd5NBOporuNOcBZZqwjEGCn1hFb0PfNXIjbKqW4="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-aIcI8zPPkFV3PvRgxTUWZnsHsJIVHqWMvPa55nWqX2o="; # aarch64-darwin
      };
    };
  };
}
