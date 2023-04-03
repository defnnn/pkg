{
  inputs.pkg.url = github:defn/pkg/0.0.176;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/loft-sh/vcluster/releases/download/v${input.vendor}/vcluster-${input.os}-${input.arch}";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 $src $out/bin/vcluster
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
        sha256 = "sha256-3RqWWaC82SGEXrk8zl1SBS9HAY6zfUyZ1foz4d1OyY4="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-dpIqzKGvsh9/60Rcg4weEZkVWGfa8ipUh+P4qrIaAhQ="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-NIreO0npgoLphvXkmTYIc1hAFdfS0NdArcjls59el/I="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-eerIrT2McOiweZ03Sg+kJn9j5mL/oIvn+PxSAlwvgR0="; # aarch64-darwin
      };
    };
  };
}
