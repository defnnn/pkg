{
  inputs = {
    pkg.url = github:defn/pkg/0.0.183;
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
    };
  };
}
