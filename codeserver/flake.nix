{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "code-server";
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://github.com/coder/code-server/releases/download/v${input.version}/code-server-${input.version}-${input.os}-${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-PqecncA1ROoGq+faZgwbwOQ3YzcHAhHZj/qMM4ic1X4="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-bp/ttybrE7XvYKd78Woe6ZEWhLfiEekO7noOnoK6yeQ="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "macos";
          arch = "amd64";
          sha256 = "sha256-7DmroZS0B525OvXCOHUfc/sX8f4a7spzdxxcLvKQ5Ok="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "macos";
          arch = "amd64"; # code-server not avaialble for darwin arm64
          sha256 = "sha256-7DmroZS0B525OvXCOHUfc/sX8f4a7spzdxxcLvKQ5Ok="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        set -x
        install -m 0755 -d $out $out/bin $out/lib
        rsync -ia . $out/lib/.
        mv -f $out/lib/code-server-${vendor}-*  $out/lib/code-server-${vendor}
        ln -fs $out/lib/code-server-${vendor}/bin/code-server $out/bin/code-server
        ln -fs $out/lib/code-server-${vendor}/lib/vscode/bin/helpers/browser.sh $out/bin/browser.sh
      '';
    };

    handler = { pkgs, wrap, system }:
      wrap.genDownloadBuilders {
        dontFixup = true;
        buildInputs = with pkgs; [ rsync ];
      };
  };
}
