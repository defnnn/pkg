{
  inputs = {
    pkg.url = github:defn/pkg/0.0.156;
    awscli.url = github:defn/pkg/awscli-2.10.0-3?dir=awscli;
    flyctl.url = github:defn/pkg/flyctl-0.0.456-2?dir=flyctl;
  };

  outputs = inputs: inputs.pkg.main rec {
    src = ./.;

    defaultPackage = ctx: ctx.wrap.nullBuilder {
      propagatedBuildInputs = ctx.wrap.flakeInputs;
    };
  };
}
