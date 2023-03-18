{
  inputs.pkg.url = github:defn/pkg/0.0.169;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://dl.k8s.io/release/v${input.vendor}/bin/${input.os}/${input.arch}/kubectl";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 $src $out/bin/kubectl
    '';

    downloads = {
      options = pkg: {
        dontUnpack = true;
      };

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-uodq7w6dfi6P7awDbsGU3l7JttKVPjD/gqJ1jGujIXQ="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-Gk4oUOlNRAOcc+rnpuAFs+FDXACmK9WN92Q73rhHXP0="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-81xihy/gXd3bENv6nr0Lm4ho3mqqj7tIGmi+LdMiucU="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-2MGKn3uoKnyin1G4Nz2chFRB6kWXf3/iH/fXkd3A9/E="; # aarch64-darwin
      };
    };
  };
}
