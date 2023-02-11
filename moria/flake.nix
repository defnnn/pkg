{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.19?dir=dev;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = builtins.readFile ./SLUG; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      version = builtins.readFile ./VERSION;
      commands = [ "moria" ];
    };

    handler = { pkgs, wrap, system, builders }: rec {
      defaultPackage = wrap.nullBuilder {
        propagatedBuildInputs = [
          packages.moria
        ];
      };

      packages = builders.go;
    };
  };
}
