{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/22.05;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = inputs: rec {
    nixpkgs = inputs.nixpkgs;
    flake-utils = inputs.flake-utils;

    wrap = { other, system }:
      let
        inputsList = (nixpkgs.lib.attrsets.mapAttrsToList (name: value: value) other);
        hasDefaultPackage = (item: acc:
          acc ++
          (
            if item ? ${"defaultPackage"}
            then [ item.defaultPackage.${system} ]
            else [ ]
          ));
      in
      rec {
        devShell = nixpkgs.mkShell
          rec {
            buildInputs =
              [ other.self.defaultPackage.${system} ]
              ++ nixpkgs.lib.lists.foldr hasDefaultPackage [ ] inputsList;
          };
      };
  };
}
