{
  inputs = {
    pkg.url = github:defn/pkg/0.0.166;
    tilt.url = github:defn/pkg/tilt-0.31.2-2?dir=tilt;
    gh.url = github:defn/pkg/gh-2.23.0-2?dir=gh;
    earthly.url = github:defn/pkg/earthly-0.7.1-0?dir=earthly;
    buildkite.url = github:defn/pkg/buildkite-3.44.0-1?dir=buildkite;
    bk.url = github:defn/pkg/bk-2.0.0-0?dir=bk;
  };

  outputs = inputs: inputs.pkg.main rec {
    src = ./.;

    apps = ctx: {
      coder = {
        type = "app";
        program = "${inputs.coder.defaultPackage.${ctx.system}}/bin/coder";
      };
      codeserver = {
        type = "app";
        program = "${inputs.codeserver.defaultPackage.${ctx.system}}/bin/code-server";
      };
    };

    defaultPackage = ctx: ctx.wrap.nullBuilder {
      propagatedBuildInputs =
        let
          flakeInputs = [
            inputs.caddy.defaultPackage.${ctx.system}
            inputs.coder.defaultPackage.${ctx.system}
            inputs.codeserver.defaultPackage.${ctx.system}
            inputs.terraform.defaultPackage.${ctx.system}
            inputs.tilt.defaultPackage.${ctx.system}
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
