{
  inputs.dev.url = github:defn/pkg/dev-0.0.27?dir=dev;
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
          caller = inputs.dev.defaultConfig {
            src = clr.src;
            config = clr;
          };

          src = builtins.path { path = caller.src; name = (builtins.fromJSON (builtins.readFile "${caller.src}/flake.json")).slug; };

          config = caller // { inherit src; };
        in
        inputs.dev.main rec {
          inherit inputs;
          inherit src;
          inherit config;
          handler = ctx:
            let
              options = caller.downloads.options { inherit ctx; };
              downloads = ctx.wrap.genDownloadBuilders ({ inherit config; } // options);
              devshell = ctx.wrap.devShell {
                devInputs = [ downloads.defaultPackage ];
              };
              this = downloads // { devShell = devshell; } // extend;
              extend = caller.extend { inherit ctx; inherit this; };
            in
            this // extend;
        };
    in
    {
      inherit main;
      inherit downloadMain;

      dev = inputs.dev;
      nixpkgs = inputs.dev.pkgs;
    } // inputs.dev.main rec {
      inherit inputs;

      src = builtins.path { path = ./.; name = (builtins.fromJSON (builtins.readFile ./flake.json)).slug; };

      config = inputs.dev.defaultConfig { inherit src; };

      handler = ctx: {
        defaultPackage = ctx.wrap.nullBuilder { };
      };
    };
}
