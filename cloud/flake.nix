{
  inputs = {
    pkg.url = github:defn/pkg/0.0.166;
    awscli.url = github:defn/pkg/awscli-2.10.0-3?dir=awscli;
    flyctl.url = github:defn/pkg/flyctl-0.0.462-0?dir=flyctl;
  };

  outputs = inputs: inputs.pkg.main rec {
    src = ./.;

    defaultPackage = ctx: ctx.wrap.nullBuilder {
      propagatedBuildInputs =
        let
          flakeInputs = [
            inputs.awscli.defaultPackage.${ctx.system}
            inputs.flyctl.defaultPackage.${ctx.system}
          ];
        in
        flakeInputs;
    };
  };
}
