{
  inputs.pkg.url = github:defn/pkg/0.0.156;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    extend = pkg: { };

    url_template = input: "https://github.com/charmbracelet/gum/releases/download/v${input.vendor}/gum_${input.vendor}_${input.os}_${input.arch}.tar.gz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 gum $out/bin/gum
    '';

    downloads = {
      options = pkg: { };

      "x86_64-linux" = {
        os = "Linux";
        arch = "x86_64";
        sha256 = "sha256-l7xoSkeqKJvkP4O0yUCwCyizTuSo1cWql5lm9KuSeks="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "Linux";
        arch = "arm64";
        sha256 = "sha256-CNjO2am6UbY1pyYdOmKcLAKqx1irGpuzizHG2Bchcvs="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "Darwin";
        arch = "x86_64";
        sha256 = "sha256-2HUuBJZFW/3N2yITUjd3tnnI64bD2qyKts4Og67v87U="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "Darwin";
        arch = "arm64";
        sha256 = "sha256-PDVG9VCwfGB3hu9wV/GSGPAHrbGSkin1yt3KcURsFSI="; # aarch64-darwin
      };
    };
  };
}
