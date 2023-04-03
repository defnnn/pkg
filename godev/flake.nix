{
  inputs = {
    pkg.url = github:defn/pkg/0.0.188;
    buf.url = github:defn/pkg/buf-1.16.0-15?dir=buf;
    operatorsdk.url = github:defn/pkg/operatorsdk-1.28.0-17?dir=operatorsdk;
    goreleaser.url = github:defn/pkg/goreleaser-1.16.2-17?dir=goreleaser;
    cosign.url = github:defn/pkg/cosign-2.0.0-19?dir=cosign;
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
          inputs.buf.defaultPackage.${ctx.system}
          inputs.operatorsdk.defaultPackage.${ctx.system}
          inputs.goreleaser.defaultPackage.${ctx.system}
          inputs.cosign.defaultPackage.${ctx.system}
        ];
    };
  };
}
