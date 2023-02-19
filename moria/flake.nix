{
  inputs.pkg.url = github:defn/pkg/0.0.156;
  outputs = inputs: inputs.pkg.main rec {
    src = ./.;

    commands = [ "moria" ];

    defaultPackage = ctx: ctx.wrap.nullBuilder {
      propagatedBuildInputs = [
        ctx.builders.go.moria
      ];
    };
  };
}
