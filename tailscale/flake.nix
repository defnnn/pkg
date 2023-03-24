{
  inputs.pkg.url = github:defn/pkg/0.0.170;
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
        sha256 = "sha256-dslKr2XPSkqoEqIeSx7dMsg49ZWlOYnek8cPIulL5nU="; # x86_64-linux
      };
      "aarch64-linux" = {
        arch = "arm64";
        sha256 = "sha256-g+NSal1NkBlNnEBFbSZ20xfX0dUgK4bvk1AN1cLl7NI="; # aarch64-linux
      };
    };
  };
}
