{
  inputs.pkg.url = github:defn/pkg/0.0.173;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    extend = pkg: {
      apps.default = {
        type = "app";
        program = "${pkg.this.defaultPackage}/bin/tailscale";
      };

      apps.tailscaled = {
        type = "app";
        program = "${pkg.this.defaultPackage}/bin/tailscaled";
      };
    };

    url_template = input: "https://pkgs.tailscale.com/stable/tailscale_${input.vendor}_${input.arch}.tgz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 */tailscale $out/bin/tailscale
      install -m 0755 */tailscaled $out/bin/tailscaled
    '';

    downloads = {
      

      "x86_64-linux" = {
        arch = "amd64";
        sha256 = "sha256-SaDraC5cA0ZqbkuO+TPypLfj2HU0TOhbYVKg6YWT7qU="; # x86_64-linux
      };
      "aarch64-linux" = {
        arch = "arm64";
        sha256 = "sha256-5SVrLtPYk3Ikz/fQlQ8C6P8r/T34t07iHsdpmspqiV0="; # aarch64-linux
      };
    };
  };
}
