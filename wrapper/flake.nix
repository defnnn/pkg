{
  inputs = { };

  outputs = inputs: {
    wrap = { other, system, pkgs }:
      let
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
        defaultPackage = other.defaultPackage.${system};
        devShell = pkgs.mkShell
          rec {
            buildInputs =
              values.buildInputs
              ++ [ other.self.defaultPackage.${system} ]
              ++ pkgs.lib.lists.foldr hasDefaultPackage [ ] inputsList;
          };
      };
  };
}
