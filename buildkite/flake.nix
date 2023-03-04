{
  inputs.pkg.url = github:defn/pkg/0.0.166;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/buildkite/agent/releases/download/v${input.vendor}/buildkite-agent-${input.os}-${input.arch}-${input.vendor}.tar.gz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 buildkite-agent $out/bin/buildkite-agent
    '';

    downloads = {


      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-/9VCg2+3u6grRM6wTM+V+jbPXDPWL0HhG41kJWgzLdk="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-Sw61Fma4lTKXSIV+gd4sKjLRugpjC0WyXDczrvOALsY="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-SBfOmt8X34cr59jHM7ZR0owRqAUO2JAWKsYx3pOhxTg="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "amd64"; # no arm64 macos
        sha256 = "sha256-SBfOmt8X34cr59jHM7ZR0owRqAUO2JAWKsYx3pOhxTg="; # aarch64-darwin
      };
    };
  };
}
