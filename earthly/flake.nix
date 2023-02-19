{
  inputs.pkg.url = github:defn/pkg/0.0.159;
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
        sha256 = "sha256-B/uohgfBTj/X9fJ2i6XmkwP2zGN6k2PVoOyVB7maRq4="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-n2CygpKsZ1HPFDh20x6bUeWYs7U7hMlQRsfgX409JFk="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-5Fw0+mnJBk5Y7+9Z1Z1LVORtNvqOn46b6A34OjGfV+Y="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-6VJlPBIZmXpCl+rW2fS/ZlmmF0qyYjCzct+LVh8vjEk="; # aarch64-darwin
      };
    };
  };
}
