{
  inputs = {
    wrapper.url = github:defn/pkg?dir=wrapper&ref=v0.0.30;
  };

  outputs = inputs:
    {
      wrapper = inputs.wrapper;
    } //
    inputs.wrapper.flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import inputs.wrapper.nixpkgs { inherit system; };
        wrap = inputs.wrapper.wrap { other = inputs; inherit system; inherit site; };
        buildInputs = [
          pkgs.jq
          pkgs.fzf
          pkgs.docker
          pkgs.docker-credential-helpers
          pkgs.kubectl
          pkgs.k9s
          pkgs.pre-commit
        ];
        site = import ./config.nix;
      in
      with site;
      rec {
        devShell = wrap.devShell;
        defaultPackage = pkgs.stdenv.mkDerivation
          rec {
            name = "${slug}-${version}";

            src = ./.;

            dontUnpack = true;

            installPhase = ''
              mkdir -p $out/bin
              cp $src/bin/c-* $out/bin/
              chmod 755 $out/bin/*
            '';

            propagatedBuildInputs = buildInputs;

            meta = with pkgs.lib; {
              inherit homepage;
              inherit description;
            };
          };
      }
    );
}
