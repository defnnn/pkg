{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.24?dir=dev;
  };

  outputs = inputs:
    let
      main = caller: inputs.dev.main rec {
        inherit inputs;

        src = builtins.path { path = caller.src; name = (builtins.fromJSON (builtins.readFile "${caller.src}/flake.json")).slug; };

        config = caller.config;

        handler = ctx: rec {
          defaultPackage = caller.defaultPackage ctx;
        };
      };

      downloadMain = caller:
        let
          src = builtins.path { path = caller.src; name = (builtins.fromJSON (builtins.readFile "${caller.src}/flake.json")).slug; };

          config = {
            inherit src;
            url_template = caller.url_template;
            installPhase = caller.installPhase;
            downloads = caller.downloads;
          };

          mergedConfig = inputs.dev.defaultConfig config;
        in
        inputs.dev.main rec {
          inherit inputs;
          inherit src;
          config = mergedConfig;
          handler = ctx: ctx.wrap.genDownloadBuilders { inherit config; };
        };
    in
    {
      inherit main;
      inherit downloadMain;

      dev = inputs.dev;
      pkgs = inputs.dev.nixpkgs;
    } // inputs.dev.main rec {
      inherit inputs;

      src = builtins.path { path = ./.; name = (builtins.fromJSON (builtins.readFile ./flake.json)).slug; };

      config = inputs.dev.defaultConfig { inherit src; };

      handler = ctx: {
        defaultPackage = ctx.wrap.nullBuilder { };
      };
    };
}
