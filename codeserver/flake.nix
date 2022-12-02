{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.4?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "code-server";
      version_src = ./VERSION;
      version = builtins.readFile version_src;
      vendor_src = ./VENDOR;
      vendor = builtins.readFile vendor_src;

      url_template = input: "https://github.com/coder/code-server/releases/download/v${input.version}/code-server-${input.version}-${input.os}-${input.arch}.tar.gz";

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin $out/lib
        rsync -ia . $out/lib/.
        mv -f $out/lib/code-server-${vendor}-*  $out/lib/code-server-${vendor}
        ln -fs $out/lib/code-server-${vendor}/bin/code-server $out/bin/code-server
      '';

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-Fui2ANA+7HEKe01jgJhro0FOfjqlA9qQtRjU/QZuIgo=";
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-t7TNd8mS6j6YLTmfDkC5hwfOr34JYO64S6Z09UMVxZU=";
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "macos";
          arch = "amd64";
          sha256 = "sha256-NaRWZbSgK9L88cym/NR+vjVsKDo1a3fU+7XiKiC8HYY=";
        };
      };
    };

    handler = { pkgs, wrap, system }: {
      devShell = wrap.devShell;
      defaultPackage = wrap.downloadBuilder {
        buildInputs = [ pkgs.rsync ];
      };
    };
  };
}
