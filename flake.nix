{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.4?dir=dev;
    caddy.url = github:defn/pkg/caddy-2.6.2?dir=caddy;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "defn-pkg";
      version_src = ./VERSION;
      version = builtins.readFile version_src;
      vendor_src = ./VENDOR;
      vendor = builtins.readFile vendor_src;
    };

    handler = { pkgs, wrap, system }: {
      devShell = wrap.devShell;
      defaultPackage = wrap.nullBuilder { };

      packages.dev = inputs.dev.defaultPackage.${system};
      packages.caddy = inputs.caddy.defaultPackage.${system};
    };
  };
}

