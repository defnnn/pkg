{
  inputs.pkg.url = github:defn/pkg/0.0.150;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    extend = { ctx, this }: {
      apps.default = {
        type = "app";
        program = "${this.defaultPackage}/bin/coder";
      };
    };

    url_template = input:
      if input.os == "linux" then
        "https://github.com/coder/coder/releases/download/v${input.vendor}/coder_${input.vendor}_${input.os}_${input.arch}.tar.gz"
      else
        "https://github.com/coder/coder/releases/download/v${input.vendor}/coder_${input.vendor}_${input.os}_${input.arch}.zip";

    installPhase = { src }: ''
      install -m 0755 -d $out $out/bin $out/lib
      cp coder $out/bin/coder
    '';

    downloads = {
      options = { ctx }: {
        dontFixup = true;
        buildInputs = with ctx.pkgs; [ unzip ];
      };

      "x86_64-linux" = rec {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-hgJ/E1UVhxkX+8SUh+83A2FivB3r3iqBj0FdO6lR0Jw="; # x86_64-linux
      };
      "aarch64-linux" = rec {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-3JwtSZg2jx6fAR7FU3e1GbpD9WnPR0IJdeknU0kxmxE="; # aarch64-linux
      };
      "x86_64-darwin" = rec {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-PeWxJTr9pAIz4Bpw3V8xklop8/+V4V1KMvGXDTx4Cr8="; # x86_64-darwin
      };
      "aarch64-darwin" = rec {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-1ZvyuOqJtQUL/k+uuPEGbICWGZxdrAypjfrjjZnEFHw="; # aarch64-darwin
      };
    };
  };
}
