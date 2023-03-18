{
  inputs.pkg.url = github:defn/pkg/0.0.168;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    extend = pkg: {
      apps.default = {
        type = "app";
        program = "${pkg.this.defaultPackage}/bin/code-server";
      };
    };

    url_template = input: "https://github.com/coder/code-server/releases/download/v${input.vendor}/code-server-${input.vendor}-${input.os}-${input.arch}.tar.gz";

    installPhase = pkg:
      ''
        install -m 0755 -d $out $out/bin $out/lib
        rsync -ia . $out/lib/.
        mv -f $out/lib/code-server-${pkg.config.vendor}-*  $out/lib/code-server-${pkg.config.vendor}
        ln -fs $out/lib/code-server-${pkg.config.vendor}/bin/code-server $out/bin/code-server
        ln -fs $out/lib/code-server-${pkg.config.vendor}/lib/vscode/bin/helpers/browser.sh $out/bin/browser.sh
      '';

    downloads = {
      options = pkg: {
        dontFixup = true;
        buildInputs = with pkg.ctx.pkgs; [ rsync ];
      };

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-OymtjnW0iYCTPOzqliGMB9Oox5SSuzHZZlsE+aHorqQ="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-ge5xFehQo7gf9I4E1aMe6inGhgBB2ioJjzGCkYC7as0="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "macos";
        arch = "amd64";
        sha256 = "sha256-wkrx+mFwe6WjlU73bfMFXcC4eFQ2kapilgSC0Ds1fOE="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "macos";
        arch = "amd64"; # code-server not avaialble for darwin arm64
        sha256 = "sha256-wkrx+mFwe6WjlU73bfMFXcC4eFQ2kapilgSC0Ds1fOE="; # aarch64-darwin
      };
    };
  };
}
