{
  inputs.pkg.url = github:defn/pkg/0.0.141;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/bufbuild/buf/releases/download/v${input.vendor}/buf-${input.os}-${input.arch}.tar.gz";

    installPhase = { src }: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 buf/bin/buf $out/bin/buf
    '';

    downloads = {
      "x86_64-linux" = {
        os = "Linux";
        arch = "x86_64";
        sha256 = "sha256-mrOCCBhy3wP6rxks+oJWbTJDbP14eCA16UtNBKmCYg8="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "Linux";
        arch = "aarch64";
        sha256 = "sha256-HdAI5oEAYlnXzjJ1+0nH30XS+eoPszRpgKh2PqHwZZk="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "Darwin";
        arch = "x86_64";
        sha256 = "sha256-wwLMpd2XHPftOpYAvdChUY0Pb2MWCPlbKK4xCdAQ9Gc="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "Darwin";
        arch = "x86_64";
        sha256 = "sha256-wwLMpd2XHPftOpYAvdChUY0Pb2MWCPlbKK4xCdAQ9Gc="; # aarch64-darwin
      };
    };
  };
}
