{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "prelude ";
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;
    };

    handler = { pkgs, wrap, system }: {
      defaultPackage = wrap.nullBuilder { };
    };
  };
}
