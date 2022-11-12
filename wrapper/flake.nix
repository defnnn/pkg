{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/22.05;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = inputs: {
    nixpkgs = inputs.nixpkgs;
    flake-utils = inputs.flake-utils;

    wrap = { other, system }:
      let
        pkgs = import inputs.nixpkgs { inherit system; };
        inputsList = (pkgs.lib.attrsets.mapAttrsToList (name: value: value) other);
        hasDefaultPackage = (item: acc:
          acc ++
          (
            if item ? ${"defaultPackage"}
            then [ item.defaultPackage.${system} ]
            else [ ]
          ));
      in
      rec {
        devShell = pkgs.mkShell
          rec {
            buildInputs =
              [ other.self.defaultPackage.${system} ]
              ++ pkgs.lib.lists.foldr hasDefaultPackage [ ] inputsList;
          };
      };
  };
}
