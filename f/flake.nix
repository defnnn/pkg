{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.4?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "f";
      version_src = ./VERSION;
      version = builtins.readFile version_src;
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
