{
  inputs.pkg.url = github:defn/pkg/0.0.158;
  inputs.cue.url = "github:defn/pkg/hof-0.6.7-7?dir=hof";
  inputs.hof.url = "github:defn/pkg/cue-0.5.0-beta.5-2?dir=cue";
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
