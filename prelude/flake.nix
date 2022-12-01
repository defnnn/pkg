{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.4?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "prelude ";
      version_src = ./VERSION;
      version = builtins.readFile version_src;
      vendor_src = ./VENDOR;
      vendor = builtins.readFile vendor_src;
    };

    handler = { pkgs, wrap, system }: {
      devShell = wrap.devShell;
      defaultPackage = wrap.nullBuilder { };
    };
  };
}
