{
  inputs = {
    wrapper.url = github:defn/pkg/wrapper-0.0.11?dir=wrapper;
    gomod2nix.url = github:defn/gomod2nix/1.5.0-1;
    yaegi.url = github:defn/pkg/yaegi-0.14.3-1?dir=yaegi;
  };

  outputs = inputs:
    let
      prelude = rec {
        wrapper = inputs.wrapper;

        eachDefaultSystem = wrapper.flake-utils.lib.eachDefaultSystem;

        gomod2nixOverlay = inputs.gomod2nix.overlays.default;

        dev-inputs = inputs;

        main = { inputs, config, handler, src }: eachDefaultSystem (system:
          let
            pkgs = import wrapper.nixpkgs {
              inherit system;
              overlays = [ gomod2nixOverlay ];
            };
            wrap = wrapper.wrap { other = inputs; inherit system; site = config; };
            handled = handler
              {
                inherit pkgs;
                inherit wrap;
                inherit system;

                builders = if src == "" then { } else {
                  yaegi = wrap.yaegiBuilder { inherit src; inputs = { yaegi = dev-inputs.yaegi; } // inputs; };
                  bb = wrap.bbBuilder { inherit src; inherit inputs; };
                };
              };
            defaults = {
              slug = config.slug;
              devShell = wrap.devShell {
                devInputs = [ pkgs.gomod2nix ];
              };
            };
          in
          defaults // handled
        );
      };
    in
    prelude // (prelude.main {
      inherit inputs;

      src = ./.;

      config = {
        slug = "defn-pkg-dev";
        version = builtins.readFile ./VERSION;
      };

      handler = { pkgs, wrap, system, builders }: {
        defaultPackage = wrap.bashBuilder {
          propagatedBuildInputs = [ pkgs.gomod2nix ];

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
