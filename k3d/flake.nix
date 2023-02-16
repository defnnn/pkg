{
  inputs.pkg.url = github:defn/pkg/0.0.142;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/k3d-io/k3d/releases/download/v${input.vendor}/k3d-${input.os}-${input.arch}";

    installPhase = { src }: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 $src $out/bin/k3d
    '';

    downloads = {
      options = { dontUnpack = true; };

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-xUIY1b9studJh78h94IEg/WBsAxJ/uEdvbjBfHgpoCU="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-yM61XtL/4gFbkVhI0Lbqpy28E1gnDe5ODBI1jBYjHUA="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-imKlRXVRczX7rahFyvt1oFjJD3t76D532oZmAlB8qnE="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-yYEelLlpH1voRhIYOwDh8ij8tGM/Qd0hVXvLDKIFtFk="; # aarch64-darwin
      };
    };
  };
}
