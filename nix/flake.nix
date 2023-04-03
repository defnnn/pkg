{
  inputs = {
    pkg.url = github:defn/pkg/0.0.174;
  };

  outputs = inputs: inputs.pkg.main rec {
    src = ./.;

    defaultPackage = ctx: ctx.wrap.nullBuilder {
      propagatedBuildInputs = with ctx.pkgs; [
        direnv
        nix-direnv
        nixpkgs-fmt
      ];
    };
  };
}
