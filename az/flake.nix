{
  inputs = {
    pkg.url = github:defn/pkg/0.0.207;
    c.url = github:defn/pkg/c-0.4.37?dir=c;
    n.url = github:defn/pkg/n-0.0.81?dir=n;
    tf.url = github:defn/pkg/tf-0.0.41?dir=tf;
    gum.url = github:defn/pkg/gum-0.10.0-34?dir=gum;
    glow.url = github:defn/pkg/glow-1.5.0-37?dir=glow;
  };

  outputs = inputs: inputs.pkg.main rec {
    src = ./.;

    defaultPackage = ctx: ctx.wrap.nullBuilder {
      propagatedBuildInputs = with ctx.pkgs; [
        inputs.c.defaultPackage.${ctx.system}
        inputs.n.defaultPackage.${ctx.system}
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
