{
  inputs.pkg.url = github:defn/pkg/0.0.208;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/sigstore/cosign/releases/download/v${input.vendor}/cosign-${input.os}-${input.arch}";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 $src $out/bin/cosign
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
        sha256 = "sha256-kkdUsuYvJWg+PnT5CqXhZpRKDwz3W0GW7nbLL0h92YA="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-SozUlRjMZnuxbmqvnaKRtkfDi6/6Ri/UlQQ65nYvaYE="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-oi2jnE4pDTrloqiCR22vhLRqwZrNCwGqyOFz1/V7jq4="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-lXdPD40LFnRgaJPjg37NPwHWXA6kpxQJsIkwf/0fm+0="; # aarch64-darwin
      };
    };
  };
}
