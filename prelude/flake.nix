{
  description = "prelude";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: {
      defaultPackage =
        with import nixpkgs { inherit system; };
        stdenv.mkDerivation rec {
          name = "${slug}-${version}";

          slug = "prelude";
          version = "0.0.2";

          dontUnpack = true;

          installPhase = "mkdir -p $out";

          meta = with lib; {
            homepage = "https://defn.sh/${slug}";
            description = "prelude containers the nixpkgs you should follow";
            platforms = platforms.linux;
          };
        };
    });
}
