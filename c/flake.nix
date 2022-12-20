{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.18?dir=dev;
    cue.url = "github:defn/pkg/cue-0.4.3-3?dir=cue";
    hof.url = "github:defn/pkg/hof-0.6.7-4?dir=hof";
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = config.slug; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      version = builtins.readFile ./VERSION;
    };

    handler = { pkgs, wrap, system, builders }: {
      defaultPackage = wrap.bashBuilder {
        src = ./bin;
        installPhase = ''
          mkdir -p $out/bin
          cp -a $src/* $out/bin/
          chmod 755 $out/bin/*
        '';

        propagatedBuildInputs = [
          inputs.cue.defaultPackage.${system}
          inputs.hof.defaultPackage.${system}
        ];
      };
    };
  };
}
