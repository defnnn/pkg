{
  inputs.pkg.url = github:defn/pkg/0.0.180;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/gruntwork-io/cloud-nuke/releases/download/v${input.vendor}/cloud-nuke_${input.os}_${input.arch}";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 $src $out/bin/cloud-nuke
    '';

    downloads = {
      options = pkg: {
        dontUnpack = true;
        dontFixup = true;
      };

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-GMWei+yk7IoeXZ+mmeAM2Os6qnKN0vW90Tl/v8SYjjI="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-vb+NnzQJrpmN8+A9/nq+O+M+PS3ETY2OegvCMJC4zSw="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-4+sB/9F70I2FiEVQ+TAs92ZUSJEPycROGsoccqJe1Ns="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-z2xFOsCLzHio/rUIG+6wxrgXrPFae2mVQgdxhTHrj9o="; # aarch64-darwin
      };
    };
  };
}
