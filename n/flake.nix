{
  inputs = {
    pkg.url = github:defn/pkg/0.0.159;
    c.url = github:defn/pkg/c-0.0.7?dir=c;
  };

  outputs = inputs: inputs.pkg.main rec {
    src = ./.;

    defaultPackage = ctx: ctx.wrap.bashBuilder {
      inherit src;

      installPhase = ''
        mkdir -p $out/bin
        cp -a $src/bin/n $src/bin/n-* $out/bin/
        chmod 755 $out/bin/*
      '';

      propagatedBuildInputs = [
        inputs.c.defaultPackage.${ctx.system}
      ];
    };
  };
}
