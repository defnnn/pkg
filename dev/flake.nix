{
  inputs = {
    wrapper.url = github:defn/pkg?dir=wrapper&ref=v0.0.30-rc9;

    c.url = github:defn/pkg?dir=c&ref=v0.0.10;
    tilt.url = github:defn/pkg?dir=tilt&ref=v0.0.4;
    earthly.url = github:defn/pkg?dir=earthly&ref=v0.0.5;
    yaegi.url = github:defn/pkg?dir=yaegi&ref=v0.0.13;
    glow.url = github:defn/pkg?dir=glow&ref=v0.0.27;
    gum.url = github:defn/pkg?dir=gum&ref=v0.0.27;
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
          inputs.c.defaultPackage.${system}
          inputs.tilt.defaultPackage.${system}
          inputs.earthly.defaultPackage.${system}
          inputs.yaegi.defaultPackage.${system}
          inputs.glow.defaultPackage.${system}
          inputs.gum.defaultPackage.${system}
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
