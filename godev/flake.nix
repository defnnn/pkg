{
  inputs = {
    pkg.url = github:defn/pkg/0.0.166;
    cobracli.url = github:defn/cobra-cli/1.6.1-1;
    buf.url = github:defn/pkg/buf-1.15.1-0?dir=buf;
    operatorsdk.url = github:defn/pkg/operatorsdk-1.27.0-0?dir=operatorsdk;
    goreleaser.url = github:defn/pkg/goreleaser-1.16.1-0?dir=goreleaser;
    cosign.url = github:defn/pkg/cosign-2.0.0-1?dir=cosign;
    latest.url = github:NixOS/nixpkgs?rev=64c27498901f104a11df646278c4e5c9f4d642db; # nixos-unstable https://lazamar.co.uk/nix-versions/
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
          inputs.operatorsdk.defaultPackage.${ctx.system}
          inputs.goreleaser.defaultPackage.${ctx.system}
        ];
    };
  };
}
