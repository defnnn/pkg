{
  inputs = {
    wrapper.url = github:defn/pkg?dir=wrapper&ref=v0.0.20;

    c.url = github:defn/pkg?dir=c&ref=v0.0.10;
    tilt.url = github:defn/pkg?dir=tilt&ref=v0.0.4;
    earthly.url = github:defn/pkg?dir=earthly&ref=v0.0.5;
    yaegi.url = github:defn/pkg?dir=yaegi&ref=v0.0.13;
  };

  outputs = inputs:
    inputs.wrapper.flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import inputs.wrapper.nixpkgs { inherit system; };
        wrap = inputs.wrapper.wrap { other = inputs; inherit system; };
        slug = "defn-pkg-dev";
        version = "0.0.1";
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
        ];
      in
      rec {
        devShell = wrap.devShell;
        defaultPackage = pkgs.stdenv.mkDerivation
          rec {
            name = "${slug}-${version}";

            dontUnpack = true;

            installPhase = "mkdir -p $out";

            propagatedBuildInputs = buildInputs;

            meta = with pkgs.lib; {
              homepage = "https://defn.sh/${slug}";
              description = "common dev tools";
              platforms = platforms.linux;
            };
          };
      }
    );
}
