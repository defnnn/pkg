{
  description = "prelude";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/22.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: {
      defaultPackage =
        with import nixpkgs { inherit system; };
        stdenv.mkDerivation rec {
          name = "${slug}-${version}";

          slug = "prelude";
          version = "0.0.1";

          dontUnpack = true;

          installPhase = "touch $out";

          meta = with lib; {
            homepage = "https://defn.sh/${slug}";
            description = "prelude containers the nixpkgs you should follow";
            platforms = platforms.linux;
          };
        };
    });
}
