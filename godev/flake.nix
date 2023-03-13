{
  inputs = {
    pkg.url = github:defn/pkg/0.0.166;
    cobracli.url = github:defn/cobra-cli/1.6.1-1;
    buf.url = github:defn/pkg/buf-1.15.1-0?dir=buf;
    latest.url = github:NixOS/nixpkgs?rev=b1f87ca164a9684404c8829b851c3586c4d9f089; # nixos-unstable
  };

  outputs = inputs: inputs.pkg.main rec {
    src = ./.;

    defaultPackage = ctx: ctx.wrap.nullBuilder {
      propagatedBuildInputs =
        with (import inputs.latest { system = ctx.system; }); [
          gcc
          go_1_20
          bashInteractive
          gotools
          go-tools
          golangci-lint
          go-outline
          gopkgs
          delve
          gopls
          inputs.cobracli.defaultPackage.${ctx.system}
          inputs.buf.defaultPackage.${ctx.system}
        ];
    };
  };
}
