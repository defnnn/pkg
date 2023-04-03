{
  inputs.pkg.url = github:defn/pkg/0.0.190;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/tilt-dev/tilt/releases/download/v${input.vendor}/tilt.${input.vendor}.${input.os}.${input.arch}.tar.gz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 tilt $out/bin/tilt
    '';

    downloads = {
      

      "x86_64-linux" = {
        os = "linux";
        arch = "x86_64";
        sha256 = "sha256-tZz0Lo9U2B9WhX4WATF8wolGJauICUR4GT8uL3A2U7o="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-CQQq81Pj8wVpc3FlnE/ILvP7Co+l2vZa32thIpXPCHI="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "mac";
        arch = "x86_64";
        sha256 = "sha256-Hvv21psltgZXIf6higZF+t2NBe3bVco9bCXvEqWOs/o="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "mac";
        arch = "arm64";
        sha256 = "sha256-23zQMsUki7Z/ZGS3/B0vPjBiDxcnzyS0D8SotdZ0XHo="; # aarch64-darwin
      };
    };
  };
}
