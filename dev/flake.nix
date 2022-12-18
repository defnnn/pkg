{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs?rev=4d2b37a84fad1091b9de401eb450aae66f1a741e;
    flake-utils.url = github:numtide/flake-utils?rev=04c1b180862888302ddfb2e3ad9eaa63afc60cf8;

    wrapper = {
      url = github:defn/pkg/wrapper-0.0.12?dir=wrapper;
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    gomod2nix = {
      url = github:defn/gomod2nix/1.5.0-1;
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "flake-utils";
    };

    yaegi.url = github:defn/pkg/yaegi-0.14.3-4?dir=yaegi;
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
    prelude // (prelude.main rec {
      inherit inputs;

      src = builtins.path { path = ./.; name = config.slug; };

      config = {
        slug = builtins.readFile ./SLUG;
        version = builtins.readFile ./VERSION;
      };

      handler = { pkgs, wrap, system, builders }: {
        defaultPackage = wrap.bashBuilder {
          inherit src;

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
