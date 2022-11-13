{
  inputs = {
    wrapper.url = github:defn/pkg?dir=wrapper&ref=v0.0.49;
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
            handler {
              inherit pkgs;
              inherit wrap;
              inherit system;
            }
          );
      };
    in
    prelude // (prelude.main {
      inherit inputs;

      config = rec {
        slug = "defn-pkg-dev";
        version = "0.0.1";
        homepage = "https://defn.sh/${slug}";
        description = "common dev tools";
      };

      handler = { pkgs, wrap, system }:
        let
          site = import ./config.nix;
          pkgs = import inputs.wrapper.nixpkgs { inherit system; };
          wrap = inputs.wrapper.wrap { other = inputs; inherit system; inherit site; };
        in
        rec {
          devShell = wrap.devShell;

          defaultPackage = wrap.bashBuilder {
            propagatedBuildInputs = with pkgs; [
              jq
              fzf
              docker
              docker-credential-helpers
              kubectl
              k9s
              pre-commit
            ];

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
