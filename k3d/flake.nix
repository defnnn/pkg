{
  inputs.pkg.url = github:defn/pkg/0.0.168;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/k3d-io/k3d/releases/download/v${input.vendor}/k3d-${input.os}-${input.arch}";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 $src $out/bin/k3d
    '';

    downloads = {
      options = pkg: { dontUnpack = true; };

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-1YvRsFa4i6TEzFK5Q3yHiSCfeKx8AHxEHEF/LM3z8TY="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-mS8+tN17Nc0JkaU41v6xTsIPNkw22DoVcKgjqrDB9C0="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-/LHq58k67j651tBImsh75sfjwziLgxm3ACm32qjnxKw="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-jg3l0RYgTsIIoUOCNGtQhWu7ZkLaMQRK4xDiGgHovHA="; # aarch64-darwin
      };
    };
  };
}
