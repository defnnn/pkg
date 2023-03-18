{
  inputs.pkg.url = github:defn/pkg/0.0.167;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://releases.hashicorp.com/boundary/${input.vendor}/boundary_${input.vendor}_${input.os}_${input.arch}.zip";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      unzip $src
      install -m 0755 boundary $out/bin/boundary
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
        sha256 = "sha256-90u7t66GsCyvYDNQKrd9H7wOo4xNA1HMtWiUOFJp7uM="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-E458HKAnR+omhJ0N3+lsEMkIuI0NbXFMCWVrPn5pVFE="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-NeK2Z2T2kylKPgE20SyriLHxTW1l163wHZST4JuIX8E="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-/rp/QoW768mtXWZ/SQ6u6zG1+7FzJna5b22syS7qMi8="; # aarch64-darwin
      };
    };
  };
}
