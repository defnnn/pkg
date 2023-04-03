{
  inputs = {
    pkg.url = github:defn/pkg/0.0.186;
    tilt.url = github:defn/pkg/tilt-0.32.0-14?dir=tilt;
    nomad.url = github:defn/pkg/nomad-1.5.2-14?dir=nomad;
    boundary.url = github:defn/pkg/boundary-0.12.1-13?dir=boundary;
    vault.url = github:defn/pkg/vault-1.13.1-14?dir=vault;
    gh.url = github:defn/pkg/gh-2.25.1-14?dir=gh;
    earthly.url = github:defn/pkg/earthly-0.7.2-13?dir=earthly;
    buildkite.url = github:defn/pkg/buildkite-3.45.0-13?dir=buildkite;
    bk.url = github:defn/pkg/bk-2.0.0-16?dir=bk;
    buildevents.url = github:defn/pkg/buildevents-0.13.0-13?dir=buildevents;
    honeyvent.url = github:defn/pkg/honeyvent-1.1.3-13?dir=honeyvent;
    honeymarker.url = github:defn/pkg/honeymarker-0.2.10-15?dir=honeymarker;
    honeytail.url = github:defn/pkg/honeytail-1.8.2-14?dir=honeytail;
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
            inputs.buildevents.defaultPackage.${ctx.system}
            inputs.honeyvent.defaultPackage.${ctx.system}
            inputs.honeymarker.defaultPackage.${ctx.system}
            inputs.honeytail.defaultPackage.${ctx.system}
          ];
        in
        flakeInputs;
    };
  };
}
