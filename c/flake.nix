{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/22.11";
    flake-utils.url = "github:numtide/flake-utils";
    cue-pkg.url = "github:defn/pkg/v0.0.5?dir=cue";
    hof-pkg.url = "github:defn/pkg/v0.0.5?dir=hof";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , cue-pkg
    , hof-pkg
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      cue = cue-pkg.defaultPackage.${system};
      hof = hof-pkg.defaultPackage.${system};
    in
    rec {
      devShell =
        pkgs.mkShell rec {
          buildInputs = with pkgs; [
            defaultPackage
            cue
            hof
          ];
        };

      defaultPackage =
        with import nixpkgs { inherit system; };
        stdenv.mkDerivation rec {
          name = "${slug}-${version}";

          slug = "c";
          version = "0.0.2";

          src = ./bin;

          dontUnpack = true;

          installPhase = ''
            mkdir -p $out/bin
            cp -a $src/* $out/bin/
            chmod 755 $out/bin/c $out/bin/c-*
          '';

          propagatedBuildInputs = with pkgs; [
            getopt
            cue
            hof
          ];

          meta = with lib; {
            homepage = "https://defn.sh/${slug}";
            description = "common utility: c";
            platforms = platforms.linux;
          };
        };
    });
}
