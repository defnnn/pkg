{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10-rc3?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "f";
      version = builtins.readFile ./VERSION;
    };

    handler = { pkgs, wrap, system }: {
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
