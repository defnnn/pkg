{
  inputs = {
    pkg.url = github:defn/pkg/0.0.190;
  };

  outputs = inputs: inputs.pkg.main rec {
    src = ./.;

    defaultPackage = ctx: ctx.wrap.nullBuilder {
      propagatedBuildInputs = with ctx.pkgs; [
        vim
        openssh
        screen
        powerline-go
        less
        groff
        bashInteractive
      ];
    };
  };
}
