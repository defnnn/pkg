{
  inputs = {
    pkg.url = github:defn/pkg/0.0.166;
    c.url = github:defn/pkg/c-0.0.7?dir=c;
    n.url = github:defn/pkg/n-0.0.17?dir=n;
    f.url = github:defn/pkg/f-0.0.6?dir=f;
    tf.url = github:defn/pkg/tf-0.0.6?dir=tf;
    gum.url = github:defn/pkg/gum-0.9.0-2?dir=gum;
    glow.url = github:defn/pkg/glow-1.5.0-2?dir=glow;
  };

  outputs = inputs: inputs.pkg.main rec {
    src = ./.;

    defaultPackage = ctx: ctx.wrap.nullBuilder {
      propagatedBuildInputs = with ctx.pkgs; [
        inputs.c.defaultPackage.${ctx.system}
        inputs.n.defaultPackage.${ctx.system}
        inputs.f.defaultPackage.${ctx.system}
        inputs.tf.defaultPackage.${ctx.system}
        inputs.gum.defaultPackage.${ctx.system}
        inputs.glow.defaultPackage.${ctx.system}
        jq
        yq
        gron
        fzf
        bashInteractive
      ];
    };
  };
}
