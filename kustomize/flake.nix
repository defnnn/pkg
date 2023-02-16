{
  inputs.pkg.url = github:defn/pkg/0.0.139;
  outputs = inputs: inputs.pkg.downloadMain {
    src = ./.;

    url_template = input: "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${input.vendor}/kustomize_v${input.vendor}_${input.os}_${input.arch}.tar.gz";

    installPhase = { src }: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 kustomize $out/bin/kustomize
    '';

    downloads = {
      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-LowoqAziE1KCUfSJ240ty+p8Y7mGyPdZWjn8dv+HHNc="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-6XsSqD57mwQHysl8rEwlvBNcQjg703ZNVUTjLJZULso="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-db0Od2oeHERjmqAXu6m2owXOczK4m56Aiemf7iuD0Eo="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-dMV2qdbenWq7PohhQWNbgejPPCMxsBFTXU6LURnykds="; # aarch64-darwin
      };
    };
  };
}
