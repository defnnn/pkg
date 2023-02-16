{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.24-rc1?dir=dev;
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

      downloadMain = caller: inputs.dev.main rec {
        inherit inputs;

        src = builtins.path { path = caller.src; name = (builtins.fromJSON (builtins.readFile "${caller.src}/flake.json")).slug; };

        config = caller.config;

        handler = ctx: ctx.wrap.genDownloadBuilders { };
      };
    in
    {
      inherit main;
      inherit downloadMain;
    } // inputs.dev.main rec {
      inherit inputs;

      src = builtins.path { path = ./.; name = (builtins.fromJSON (builtins.readFile ./flake.json)).slug; };

      config = inputs.dev.defaultConfig { inherit src; };

      handler = { pkgs, wrap, system, builders, commands, config }: {
        defaultPackage = wrap.nullBuilder {
          propagatedBuildInputs = with pkgs; [ cachix ];
        };
      };
    };
}
