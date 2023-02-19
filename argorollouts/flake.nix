{
  inputs.pkg.url = github:defn/pkg/0.0.156;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    extend = pkg: { };

    url_template = input: "https://github.com/argoproj/argo-rollouts/releases/download/v${input.vendor}/kubectl-argo-rollouts-${input.os}-${input.arch}";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 $src $out/bin/argo-rollouts
    '';

    downloads = {
      options = pkg: {
        dontUnpack = true;
      };

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-IJarUoOjGmqYTOWbmW6m2YyCRv6R3Np+v0IGMqVQHc4="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-I1VrKmi028NZ7EMKifwuptqKO1/JzBYmGkojU/aW39g="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-VFM+tnptNV98OywqnfmcFgYtqep8wgHBpGTcROwxda0="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-egv4BKxRI6rfGnAiLjBlfmc5heyXUtP2LDbI5B4t/lo="; # aarch64-darwin
      };
    };
  };
}
