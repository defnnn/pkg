{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.23?dir=dev;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = builtins.readFile ./SLUG; };

    handler = { pkgs, wrap, system, builders, commands, config }: {
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
