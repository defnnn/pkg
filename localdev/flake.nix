{
  inputs = {
    pkg.url = github:defn/pkg/0.0.168;
    tilt.url = github:defn/pkg/tilt-0.31.2-3?dir=tilt;
    nomad.url = github:defn/pkg/nomad-1.5.0-1?dir=nomad;
    boundary.url = github:defn/pkg/boundary-0.12.0-1?dir=boundary;
    vault.url = github:defn/pkg/vault-1.13.0-1?dir=vault;
    gh.url = github:defn/pkg/gh-gh-2.20.2-3?dir=gh;
    earthly.url = github:defn/pkg/earthly-0.7.1-1?dir=earthly;
    buildkite.url = github:defn/pkg/buildkite-3.44.0-2?dir=buildkite;
    bk.url = github:defn/pkg/bk-2.0.0-1?dir=bk;
  };

  outputs = inputs: inputs.pkg.main rec {
    src = ./.;

    defaultPackage = ctx: ctx.wrap.nullBuilder {
      propagatedBuildInputs =
        let
          flakeInputs = [
            inputs.tilt.defaultPackage.${ctx.system}
            inputs.nomad.defaultPackage.${ctx.system}
            inputs.boundary.defaultPackage.${ctx.system}
            inputs.vault.defaultPackage.${ctx.system}
            inputs.gh.defaultPackage.${ctx.system}
            inputs.earthly.defaultPackage.${ctx.system}
            inputs.buildkite.defaultPackage.${ctx.system}
            inputs.bk.defaultPackage.${ctx.system}
          ];
        in
        flakeInputs;
    };
  };
}
