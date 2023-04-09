{
  inputs = {
    goreleaser.url = github:defn/pkg/goreleaser-1.16.2-35?dir=goreleaser;
    buf.url = github:defn/pkg/buf-1.17.0-8?dir=buf;
    operatorsdk.url = github:defn/pkg/operatorsdk-1.28.0-35?dir=operatorsdk;
    cosign.url = github:defn/pkg/cosign-2.0.1-8?dir=cosign;
    latest.url = github:NixOS/nixpkgs?rev=64c27498901f104a11df646278c4e5c9f4d642db; # nixos-unstable https://lazamar.co.uk/nix-versions/
  };

  outputs = inputs: inputs.goreleaser.inputs.pkg.main rec {
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
