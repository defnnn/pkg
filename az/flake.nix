{
  inputs = {
    pkg.url = github:defn/pkg/0.0.153;
    dev.url = github:defn/pkg/dev-0.0.22?dir=dev;
    c.url = github:defn/pkg/c-0.0.4?dir=c;
    n.url = github:defn/pkg/n-0.0.9?dir=n;
    f.url = github:defn/pkg/f-0.0.1-3?dir=f;
    tf.url = github:defn/pkg/tf-0.0.1-3?dir=tf;
    gum.url = github:defn/pkg/gum-0.8.0-3?dir=gum;
  };

  outputs = inputs: inputs.pkg.main rec {
    src = ./.;

    extend = pkg: { };

    defaultPackage = ctx: ctx.wrap.nullBuilder {
      propagatedBuildInputs = [
        inputs.c.defaultPackage.${ctx.system}
        inputs.n.defaultPackage.${ctx.system}
        inputs.f.defaultPackage.${ctx.system}
        inputs.tf.defaultPackage.${ctx.system}
        inputs.gum.defaultPackage.${ctx.system}
      ];
    };
  };
}
