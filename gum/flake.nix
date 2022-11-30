{
  inputs = {
    dev.url = github:defn/pkg/v0.0.42?dir=dev;
  };

  outputs = inputs:
    inputs.dev.wrapper.flake-utils.lib.eachDefaultSystem (system:
      let
        site = import ./config.nix;
        pkgs = import inputs.dev.wrapper.nixpkgs { inherit system; };
        wrap = inputs.dev.wrapper.wrap { other = inputs; inherit system; inherit site; };
      in
      with site;
      rec {
        devShell = wrap.devShell;
        defaultPackage = wrap.downloadBuilder;
      }
    );
}
