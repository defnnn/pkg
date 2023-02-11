{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.22?dir=dev;
    awscli.url = github:defn/pkg/awscli-2.0.30-2?dir=awscli;
    flyctl.url = github:defn/pkg/flyctl-0.0.456-0?dir=flyctl;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = builtins.readFile ./SLUG; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      version = builtins.readFile ./VERSION;
    };

    handler = { pkgs, wrap, system, builders }: rec {
      defaultPackage = wrap.nullBuilder {
        propagatedBuildInputs = wrap.flakeInputs;
      };
    };
  };
}
