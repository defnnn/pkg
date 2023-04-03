{
  inputs.pkg.url = github:defn/pkg/0.0.182;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/cli/cli/releases/download/v${input.vendor}/gh_${input.vendor}_${input.os}_${input.arch}.tar.gz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 */bin/gh $out/bin/gh
    '';

    downloads = {
      

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-hp54D5ORgEwfnTVfb3d3kx72FEfKUMdUM6WUL0hOYdE="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-1EF8lvZzFKljxAoxK2jaemFrSl1UULIrWq6Zsk6l3HA="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "macOS";
        arch = "amd64";
        sha256 = "sha256-QU9XZqULlexz/P8Xr23Fw1S0TX8EE3D+qd6PkZkMxBk="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "macOS";
        arch = "amd64"; # no arm64 macos
        sha256 = "sha256-QU9XZqULlexz/P8Xr23Fw1S0TX8EE3D+qd6PkZkMxBk="; # aarch64-darwin
      };
    };
  };
}
