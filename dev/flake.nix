{
  inputs = {
    wrapper.url = github:defn/pkg/wrapper-0.0.6?dir=wrapper;
  };

  outputs = inputs:
    let
      prelude = rec {
        wrapper = inputs.wrapper;

        eachDefaultSystem = wrapper.flake-utils.lib.eachDefaultSystem;

        main = { inputs, config, handler }:
          eachDefaultSystem (system:
            let
              pkgs = import wrapper.nixpkgs { inherit system; };
              wrap = wrapper.wrap { other = inputs; inherit system; site = config; };
            in
            handler
              {
                inherit pkgs;
                inherit wrap;
                inherit system;
              } // { slug = config.slug; }
          );
      };
    in
    prelude // (prelude.main {
      inherit inputs;

      config = rec {
        slug = "defn-pkg-dev";
        version_src = ./VERSION;
        version = builtins.readFile version_src;
      };

      handler = { pkgs, wrap, system }:
        {
          devShell = wrap.devShell;

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
