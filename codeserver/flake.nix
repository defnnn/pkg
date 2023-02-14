{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.22?dir=dev;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = builtins.readFile ./SLUG; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      revision = builtins.readFile ./REVISION;
      vendor = builtins.readFile ./VENDOR;
      version = "${vendor}-${revision}";

      url_template = input: "https://github.com/coder/code-server/releases/download/v${input.version}/code-server-${input.version}-${input.os}-${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-4yTWhKVayxKXdQvEAuFZ/mG88HaYoaIPfJI1gKOQB4g="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-qVTFe2oOsA/LIbC78mKR1O01M/EJZXKAYh27cJ0/ShM="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "macos";
          arch = "amd64";
          sha256 = "sha256-Ogs8znVwj3O4s0tQ8WaTpA6g2ltbNDjnvimriJRyumY="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "macos";
          arch = "amd64"; # code-server not avaialble for darwin arm64
          sha256 = "sha256-Ogs8znVwj3O4s0tQ8WaTpA6g2ltbNDjnvimriJRyumY="; # aarch64-darwin
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

    handler = { pkgs, wrap, system, builders }:
      let
        this = wrap.genDownloadBuilders
          {
            dontFixup = true;
            buildInputs = with pkgs; [ rsync ];
          };
      in
      this // {
        apps.default = {
          type = "app";
          program = "${this.defaultPackage}/bin/code-server";
        };
      };
  };
}
