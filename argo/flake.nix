{
  inputs.pkg.url = github:defn/pkg/0.0.141;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/argoproj/argo-workflows/releases/download/v${input.vendor}/argo-${input.os}-${input.arch}.gz";

    installPhase = { src }: ''
      cat $src | gunzip > argo
      install -m 0755 -d $out $out/bin
      install -m 0755 argo $out/bin/argo
    '';

    downloads = {
      options = {
        dontUnpack = true;
      };

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-BSj/DAqoej8VA3bu4vGybotB65ZXjEPXFckGMEYn06E="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-bZU/Zn3tZo81G/65TzLjS3C63CN3DBG1Xj0rwyyqJ0w="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-l1YmcpBh4EewMcZmd52S+T9K7klWYT2taJMLDKWm5Ik="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-yYz3/hcQ393EbuHUQSet1fBV01jQTBf7BACT5e9JjCw="; # aarch64-darwin
      };
    };
  };
}
