{
  inputs.pkg.url = github:defn/pkg/0.0.187;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://releases.hashicorp.com/terraform/${input.vendor}/terraform_${input.vendor}_${input.os}_${input.arch}.zip";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      unzip $src
      install -m 0755 terraform $out/bin/terraform
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
        sha256 = "sha256-Z1QcH2YxvvzCW3ZAKOVgXlkjTUQk5golZRjuHo3VBZM="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-8LTgkvKqbeMyTl5LW1EmDs9ejC9TNf96L/3E+1Soki0="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-AwPtnX5aIl/C5vqb92/GV0wMA1nyLV38BLyLMjRET3w="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-dWAtnsSRmCzqvqgTVpV5spkQk6Tg12t8qG/9m3oqHR4="; # aarch64-darwin
      };
    };
  };
}
