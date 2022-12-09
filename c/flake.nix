{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10?dir=dev;
    cue.url = "github:defn/pkg/cue-0.4.3-1?dir=cue";
    hof.url = "github:defn/pkg/hof-0.6.7-2?dir=hof";
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "c";
      version = builtins.readFile ./VERSION;
    };

    handler = { pkgs, wrap, system }: {
      defaultPackage = wrap.bashBuilder {
        src = ./bin;
        installPhase = ''
          mkdir -p $out/bin
          cp -a $src/* $out/bin/
          chmod 755 $out/bin/*
        '';

        propagatedBuildInputs = wrap.flakeInputs;
      };
    };
  };
}
