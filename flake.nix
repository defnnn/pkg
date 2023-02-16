{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.23?dir=dev;
  };

  outputs = inputs:
    let
      main = caller: inputs.dev.main rec {
        inherit inputs;

        src = builtins.path { path = caller.src; name = (builtins.fromJSON (builtins.readFile "${caller.src}/flake.json")).slug; };

        handler = { pkgs, wrap, system, builders, commands, config }@ctx: rec {
          defaultPackage = caller.defaultPackage ctx;
        };
      };
    in
    {
      inherit main;
    } // inputs.dev.main rec {
      inherit inputs;

      src = builtins.path { path = ./.; name = builtins.readFile ./SLUG; };

      handler = { pkgs, wrap, system, builders, commands, config }: {
        defaultPackage = wrap.nullBuilder {
          propagatedBuildInputs = with pkgs; [ cachix ];
        };
      };
    };
}
