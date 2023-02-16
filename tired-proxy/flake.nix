{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.23?dir=dev;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = builtins.readFile ./SLUG; };

    config = {
      commands = [ "tired-proxy" ];
    };

    handler = { pkgs, wrap, system, builders, commands, config }: rec {
      defaultPackage = wrap.nullBuilder {
        propagatedBuildInputs = [
          packages.tired-proxy
        ];
      };

      packages = builders.go;
    };
  };
}
