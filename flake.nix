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

      downloadMain = clr:
        let
          src = builtins.path { path = clr.src; name = (builtins.fromJSON (builtins.readFile "${clr.src}/flake.json")).slug; };

          config = {
            inherit src;
            url_template = clr.url_template;
            installPhase = clr.installPhase;
            downloads = clr.downloads;
          };

          caller = inputs.dev.defaultConfig clr;
        in
        inputs.dev.main rec {
          inherit inputs;
          inherit src;
          inherit config;
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
