{
  inputs.pkg.url = github:defn/pkg/0.0.153;
  outputs = inputs: inputs.pkg.main rec {
    src = ./.;

    extend = pkg: { };

    defaultPackage = ctx: ctx.wrap.bashBuilder {
      inherit src;

      installPhase = ''
        mkdir -p $out/bin
        cp -a $src/bin/* $out/bin/
        chmod 755 $out/bin/f $out/bin/f-*
      '';
    };
  };
}
