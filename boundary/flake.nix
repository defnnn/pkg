{
  inputs.pkg.url = github:defn/pkg/0.0.185;
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
        sha256 = "sha256-3XkFORcLCo0AVToKAcQkzxbkTHPHgOKG7DNd8Zx0V70="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-LVnuimYHiEAFm1zd5Y6Hwb9Pj0nRl0k2slaqvg8elfo="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-6Lsq4dNrQ5nxyhGhi056SvkvwJvLz+pm1V8rpVfl2xg="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-Uu7j31CrZQgBEFjRrKbK2S7T9vTEXK6eEVmQF4QlGoc="; # aarch64-darwin
      };
    };
  };
}
