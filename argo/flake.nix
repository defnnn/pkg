{
  inputs.pkg.url = github:defn/pkg/0.0.176;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/argoproj/argo-workflows/releases/download/v${input.vendor}/argo-${input.os}-${input.arch}.gz";

    installPhase = pkg: ''
      cat $src | gunzip > argo
      install -m 0755 -d $out $out/bin
      install -m 0755 argo $out/bin/argo
    '';

    downloads = {
      options = pkg: {
        dontUnpack = true;
      };

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-VlTTF1CZhi7wbX/1ga4bZh3qa6+gsrme16EaaMQqF8Y="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-5hZx5O9+TjeeV7sZHbJlH40CCRli0Ml2Txj6qyz8Wdk="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-ICijFdMc7W3UCE5Rm8KV5d4txJsdglhyIHZJGsrtRmM="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-VAQimFaUJRHqymuGFb9YrsbK2e0N13fQFLubxFOd24c="; # aarch64-darwin
      };
    };
  };
}
