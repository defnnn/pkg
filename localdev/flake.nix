{
  inputs = {
    pkg.url = github:defn/pkg/0.0.156;
    latest.url = github:NixOS/nixpkgs?rev=4938e72add339f76d795284cb5a3aae85d02ee53;
    caddy.url = github:defn/pkg/caddy-2.6.3-0?dir=caddy;
    coder.url = github:defn/pkg/coder-0.17.3-0?dir=coder;
    codeserver.url = github:defn/pkg/codeserver-4.10.0-rc.2-0?dir=codeserver;
    terraform.url = github:defn/pkg/terraform-1.3.4?dir=terraform;
    earthly.url = github:defn/pkg/earthly-0.7.0-rc2-0?dir=earthly;
    tilt.url = github:defn/pkg/tilt-0.31.2-0?dir=tilt;
    gh.url = github:defn/pkg/gh-2.23.0-0?dir=gh;
  };

  outputs = inputs: inputs.pkg.main rec {
    src = ./.;

    extend = pkg: {
      apps = {
        coder = {
          type = "app";
          program = "${inputs.coder.defaultPackage.${pkg.system}}/bin/coder";
        };
        codeserver = {
          type = "app";
          program = "${inputs.codeserver.defaultPackage.${pkg.system}}/bin/code-server";
        };
      };
    };

    defaultPackage = ctx: ctx.wrap.nullBuilder {
      propagatedBuildInputs =
        ctx.wrap.flakeInputs ++ (with ctx.pkgs; [
          bashInteractive

          gcc

          go
          gotools
          go-tools
          golangci-lint
          go-outline
          gopkgs
          delve

          nodejs-18_x
        ]) ++ (with (import inputs.latest { system = ctx.system; }); [
          gopls
        ]);
    };
  };
}
