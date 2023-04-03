{
  inputs.pkg.url = github:defn/pkg/0.0.191;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/honeycombio/honeytail/releases/download/v${input.vendor}/honeytail-${input.os}-${input.arch}";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 $src $out/bin/honeytail
    '';

    downloads = {
      options = pkg: {
        dontUnpack = true;
        buildInputs = with pkg.ctx.pkgs; [ unzip ];
      };

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-13QRImXujpjGIhIyRhzzbDX6+EQAXMmLQ7Vbs3V2F2Y="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-xaV6cpsMz0yg8ih8hiU4gSYE9f1n0QI3LpEhVwGv2+E="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-Scl26bmPojjCZexq/ONdQXZ6P41n3vpUe/+TNIX0CoM="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-2bwT6Weif6oxVzKiyZqU20fSEOFHclrkdbyYHwTOqzk="; # aarch64-darwin
      };
    };
  };
}
