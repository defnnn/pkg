{
  inputs = {
    wrapper.url = github:defn/pkg/wrapper-0.0.11-rc15?dir=wrapper;
  };

  outputs = inputs:
    let
      prelude = rec {
        wrapper = inputs.wrapper;

        eachDefaultSystem = wrapper.flake-utils.lib.eachDefaultSystem;

        main = { inputs, config, handler, src ? "" }: eachDefaultSystem (system:
          let
            pkgs = import wrapper.nixpkgs { inherit system; };
            wrap = wrapper.wrap { other = inputs; inherit system; site = config; };
            handled = handler
              {
                inherit pkgs;
                inherit wrap;
                inherit system;

                builders = if src == "" then { } else {
                  yaegi = wrap.yaegiBuilder { inherit src; inherit inputs; };
                  bb = wrap.bbBuilder { inherit src; inherit inputs; };
                  go = props: wrap.goBuilder ({ inherit src; buildInputs = [ pkgs.go ]; } // props);
                };
              };
            defaults = {
              slug = config.slug;
              devShell = wrap.devShell { };
            };
          in
          defaults // handled
        );
      };
    in
    prelude // (prelude.main {
      inherit inputs;

      config = rec {
        slug = "defn-pkg-dev";
        version = builtins.readFile ./VERSION;
      };

      handler = { pkgs, wrap, system, builders }: {
        defaultPackage = wrap.bashBuilder {
          src = ./.;

          installPhase = ''
            set +f
            find $src
            find .
            mkdir -p $out/bin
            cp $src/bin/c-* $out/bin/
            chmod 755 $out/bin/*
          '';
        };
      };
    });
}
