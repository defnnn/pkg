{
  inputs.pkg.url = github:defn/pkg/0.0.184;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/earthly/earthly/releases/download/v${input.vendor}/earthly-${input.os}-${input.arch}";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 $src $out/bin/earthly
    '';

    downloads = {
      options = pkg: {
        dontUnpack = true;
      };

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-NGsBXRPOpwGz0B+d0v9j6MEO6Z3ICfvH64Sa7QWh47A="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-GeON16PN0C2tSluwlBVotFYl7GiTFYqFRquT+jMhZos="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-UHpURqvzPV6XM/aGma7ThLthSHkzlZ+StphJ9Nusw2Q="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-1tHoOy/IIDP0LojR0WPT21ScDLK8oCXu7ctyT/ZlrUA="; # aarch64-darwin
      };
    };
  };
}
