{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10-rc3?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "defn-pkg";
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;
    };

    handler = { pkgs, wrap, system }: {
      defaultPackage = wrap.nullBuilder { };

      packages.dev = inputs.dev.defaultPackage.${system};
    };
  };
}
