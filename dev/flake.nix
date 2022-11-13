{
  inputs = {
    wrapper.url = github:defn/pkg?dir=wrapper&ref=v0.0.46;
  };

  outputs = inputs:
    rec {
      wrapper = inputs.wrapper;

      eachDefaultSystem = wrapper.flake-utils.lib.eachDefaultSystem;
    } //
    inputs.wrapper.flake-utils.lib.eachDefaultSystem (system:
      let
        site = import ./config.nix;
        pkgs = import inputs.wrapper.nixpkgs { inherit system; };
        wrap = inputs.wrapper.wrap { other = inputs; inherit system; inherit site; };
      in
      rec {
        devShell = wrap.devShell;
        defaultPackage = wrap.bashBuilder {
          propagatedBuildInputs = [
            pkgs.jq
            pkgs.fzf
            pkgs.docker
            pkgs.docker-credential-helpers
            pkgs.kubectl
            pkgs.k9s
            pkgs.pre-commit
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
      }
    );
}
