{
  inputs.pkg.url = github:defn/pkg/0.0.187;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input:
      if input.os == "Linux" then
        "https://github.com/tektoncd/cli/releases/download/v${input.vendor}/tkn_${input.vendor}_${input.os}_${input.arch}.tar.gz"
      else
        "https://github.com/tektoncd/cli/releases/download/v${input.vendor}/tkn_${input.vendor}_${input.os}_all.tar.gz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 tkn $out/bin/tkn
    '';

    downloads = {
      options = pkg: { };

      "x86_64-linux" = rec {
        os = "Linux";
        arch = "x86_64";
        sha256 = "sha256-NBCHZvr0y1jbEsArhyUx9nK3mKARMWqdPA909BhTLpA="; # x86_64-linux
      };
      "aarch64-linux" = rec {
        os = "Linux";
        arch = "aarch64";
        sha256 = "sha256-F0ogoh9aQEZJaLONnG/RFoVLCH/9xDYjKYTuXXGYZbE="; # aarch64-linux
      };
      "x86_64-darwin" = rec {
        os = "Darwin";
        arch = "all";
        sha256 = "sha256-PLl5WJqIftKl1b7MN08F0xDwCCp7cpYM5/HVPHJbI5Y="; # x86_64-darwin
      };
      "aarch64-darwin" = rec {
        os = "Darwin";
        arch = "all";
        sha256 = "sha256-PLl5WJqIftKl1b7MN08F0xDwCCp7cpYM5/HVPHJbI5Y="; # aarch64-darwin
      };
    };
  };
}
