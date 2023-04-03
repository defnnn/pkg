{
  inputs.pkg.url = github:defn/pkg/0.0.174;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/smallstep/cli/releases/download/v${input.vendor}/step_${input.os}_${input.vendor}_${input.arch}.tar.gz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 */bin/step $out/bin/step
    '';

    downloads = {
      

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-ch1528RjTp5AjiQy0HIZ5nhIkGtAlE3U7pl5u4h4Gug="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-ilhnpRXOD+TJgIUciJgGDqOECEFQVDhMYiDK8uJc2H8="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-+1btQfhauQiBgJxzdLK1NxppLjNtMFgYACpAVbBa2pg="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-W9TRLou5tDjiCKyW/0E7Hs0zKmwepUbT8yom9xQXkvA="; # aarch64-darwin
      };
    };
  };
}
