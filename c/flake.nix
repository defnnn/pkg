{
  inputs.pkg.url = github:defn/pkg/0.0.169;
  inputs.cue.url = "github:defn/pkg/hof-0.6.8-beta.12-0?dir=hof";
  inputs.hof.url = "github:defn/pkg/cue-0.5.0-beta.5-3?dir=cue";
  outputs = inputs: inputs.pkg.main rec {
    src = ./.;

    defaultPackage = ctx: ctx.wrap.bashBuilder {
      src = ./bin;

      installPhase = ''
        mkdir -p $out/bin
        cp -a $src/* $out/bin/
        chmod 755 $out/bin/*
      '';

      propagatedBuildInputs = [
        inputs.cue.defaultPackage.${ctx.system}
        inputs.hof.defaultPackage.${ctx.system}
      ];
    };
  };
}
