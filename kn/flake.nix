{
  inputs.pkg.url = github:defn/pkg/0.0.190;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/knative/client/releases/download/knative-v${input.vendor}/kn-${input.os}-${input.arch}";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 $src $out/bin/kn
    '';

    downloads = {
      options = pkg: {
        dontUnpack = true;
        dontFixup = true;
        buildInputs = with pkg.ctx.pkgs; [ unzip ];
      };

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-jsnnOE+J/84LKi9rZBueByk1g7e400tUHwjcTkHSk3g="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-AWI4gfLDxwAYvqlap5l2aS7CEigO3S410kCxkCyII+M="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-Oy6v75IXdJcWLv6glLRvof89G5092G4E9fxgNIWlEJM="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-bu9IdSHTtEj6oPQ5b4McBt1rETO1wbQCKdVtdZIJykw="; # aarch64-darwin
      };
    };
  };
}
