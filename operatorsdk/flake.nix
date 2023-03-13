{
  inputs.pkg.url = github:defn/pkg/0.0.166;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/operator-framework/operator-sdk/releases/download/v${input.vendor}/operator-sdk_${input.os}_${input.arch}";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 $src $out/bin/operator-sdk
    '';

    downloads = {
      options = pkg: {
        dontUnpack = true;
        dontFixup = true;
      };

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-2VM3LUFC+FkE8WE4gfPXjB+1OQREWJ9UAp4zzH447hM="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-FZzKcWxk5h5e0gHP+U/u6gMGGu6RekVrC51/QdYYRcQ="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-TrctLApmoODFxbSbadfVEnkQKfD2FU35uJEZ2Q/8Nk8="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-TDTBSXbmkFOhVuahzzzOzlbw0SlZPmw0u7n3iz/gBjA="; # aarch64-darwin
      };
    };
  };
}
