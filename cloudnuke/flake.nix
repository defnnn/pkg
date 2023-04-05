{
  inputs.pkg.url = github:defn/pkg/0.0.199;
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
        sha256 = "sha256-xhR0rWSHuDCR816FxZMgA4eFXos3q7giuL9sGNJvHdI="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-gQEPyB18kUQB8uy97NyBBlAVl/kSQUu8UEC0ttTjyVg="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-bucmGP3aUBNOMCicxBVaNoP+4xitGHxRUpvoyjX16ns="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-i+9IWu71BOhb5nc0BmaaqqafKLxpCe4UdYJMTUEmH8E="; # aarch64-darwin
      };
    };
  };
}
