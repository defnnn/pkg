{
  inputs.pkg.url = github:defn/pkg/0.0.168;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/cue-lang/cue/releases/download/v${input.vendor}/cue_v${input.vendor}_${input.os}_${input.arch}.tar.gz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 cue $out/bin/cue
    '';

    downloads = {
      

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-8vRZD/M8nVcwlzyXwtdaF/JEe66LVHkVpg9V5hxa4pg="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-Dy35e6eqbku7Nhz15wsX8hDv4yHxvlR5HScvGOB2Gm0="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-pC+0Isf9jqC4sbuCiRB6QY2m3a8ON/1qyh3H1v17WDw="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-b7ZP3yM4Yi5aO/RrerwIYROG+vO2gH5cslQ9/6c8Jgk="; # aarch64-darwin
      };
    };
  };
}
