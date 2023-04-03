{
  inputs = {
    pkg.url = github:defn/pkg/0.0.192;
  };

  outputs = inputs: inputs.pkg.main rec {
    src = ./.;

    defaultPackage = ctx: ctx.wrap.nullBuilder {
      propagatedBuildInputs = with ctx.pkgs; [
        docker
        docker-credential-helpers
        skopeo
        dive
      ];
    };
  };
}
