{
  inputs = {
    pkg.url = github:defn/pkg/0.0.166;
    latest.url = github:NixOS/nixpkgs?rev=4938e72add339f76d795284cb5a3aae85d02ee53;
  };

  outputs = inputs: inputs.pkg.main rec {
    src = ./.;

    defaultPackage = ctx: ctx.wrap.nullBuilder {
      propagatedBuildInputs =
        with ctx.pkgs; [
          bashInteractive

          gcc

          go
          gotools
          go-tools
          golangci-lint
          go-outline
          gopkgs
          delve
        ] ++ (with (import inputs.latest { system = ctx.system; }); [
          gopls
        ]);
    };
  };
}
