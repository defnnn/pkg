{
  inputs = {
    dev.url = github:defn/pkg/v0.0.56?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "f";
      version = "0.0.1";
      homepage = "https://github.com/defn/pkg/tree/master/${slug}";
      description = "${slug}";
    };

    handler = { pkgs, wrap, system }: rec {
      devShell = wrap.devShell;
      defaultPackage = wrap.bashBuilder {
        src = ./bin;
        installPhase = ''
          mkdir -p $out/bin
          cp -a $src/* $out/bin/
          chmod 755 $out/bin/f $out/bin/f-*
        '';
      };
    };
  };
}
