{
  inputs = {
    wrapper.url = github:defn/pkg?dir=wrapper&ref=wrapper-0.0.2-rc1;
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
        description = "common dev tools, patterns";
      };

      handler = { pkgs, wrap, system }:
        {
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
