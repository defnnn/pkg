{
  inputs.pkg.url = github:defn/pkg/0.0.156;
  outputs = inputs: inputs.pkg.downloadMain {
    src = ./.;

    extend = pkg: { };

    url_template = input: "https://get.helm.sh/helm-v${input.vendor}-${input.os}-${input.arch}.tar.gz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 */helm $out/bin/helm
    '';

    downloads = {
      options = pkg: { };

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-Cxvpa2b6tHcFJvE29fGjhaR8QZI9M6qw3LUA4PbBv3w="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-kZFz6Pt6O1TXavn+uS5J6G1agMUYUCC66MOT+g8N4eg="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-JUipDlzJV8zFAWtHBgZlqdLNTVtNYdzDL13jFE0QOCY="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-Q9AZinouomOcqvqBuwWWyXvuLU5A31CzYgI0PrTVxGs="; # aarch64-darwin
      };
    };
  };
}
