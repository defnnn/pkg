{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.24-rc5?dir=dev;
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

      downloadMain = clr:
        let
          caller = inputs.pkg.dev.defaultConfig clr;
        in
        inputs.dev.main rec {
          inherit inputs;

          src = builtins.path { path = caller.src; name = (builtins.fromJSON (builtins.readFile "${caller.src}/flake.json")).slug; };

          config = caller // { inherit src; };

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
