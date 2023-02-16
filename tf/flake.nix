{
  inputs.pkg.url = github:defn/pkg/0.0.121;
  outputs = inputs: inputs.pkg.main rec {
    src = ./.;

    defaultPackage = ctx: ctx.wrap.bashBuilder {
      src = ./bin;
      installPhase = ''
        mkdir -p $out/bin
        cp -a $src/* $out/bin/
        chmod 755 $out/bin/tf $out/bin/tf-*
      '';
    };
  };
}
