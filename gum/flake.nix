{
  inputs = {
    #dev.url = github:defn/pkg?dir=dev&ref=v0.0.26;
    dev.url = path:../dev;
  };

  outputs = inputs:
    inputs.dev.wrapper.flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import inputs.dev.wrapper.nixpkgs { inherit system; };
        wrap = inputs.dev.wrapper.wrap { other = inputs; inherit system; };
        buildInputs = [
        ];
        site = import ./config.nix;
      in
      with site;
      rec {
        devShell = wrap.devShell;
        defaultPackage = wrap.downloadBuilder {
          inherit site;
          inherit pkgs;
          inherit system;

          installPhase = ''
            install -m 0755 -d $out/bin
            install -m 0755 gum $out/bin/gum
          '';

        };
      }
    );
}
