{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.18?dir=dev;
    c.url = github:defn/pkg/c-0.0.3?dir=c;
    n.url = github:defn/pkg/n-0.0.7?dir=n;
    f.url = github:defn/pkg/f-0.0.1-3?dir=f;
    tf.url = github:defn/pkg/tf-0.0.1-3?dir=tf;
    gum.url = github:defn/pkg/gum-0.8.0-3?dir=gum;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = config.slug; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      version = builtins.readFile ./VERSION;
    };

    handler = { pkgs, wrap, system, builders }: {
      defaultPackage = wrap.nullBuilder {
        propagatedBuildInputs = [
          inputs.c.defaultPackage.${system}
          inputs.n.defaultPackage.${system}
          inputs.f.defaultPackage.${system}
          inputs.tf.defaultPackage.${system}
        ];
      };
    };
  };
}
