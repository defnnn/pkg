{
  inputs = {
    pkg.url = github:defn/pkg/0.0.167;
  };

  outputs = inputs: inputs.pkg.main rec {
    src = ./.;

    defaultPackage = ctx: ctx.wrap.nullBuilder {
      propagatedBuildInputs =
        with ctx.pkgs; [
          bashInteractive
          nodejs-18_x
        ];
    };
  };
}
