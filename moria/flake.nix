{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.23?dir=dev;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = builtins.readFile ./SLUG; };

    config = rec {
      commands = [ "moria" ];
    };

    handler = { pkgs, wrap, system, builders, commands, config }: rec {
      defaultPackage = wrap.nullBuilder {
        propagatedBuildInputs = [
          packages.moria
        ];
      };

      packages = builders.go;
    };
  };
}
