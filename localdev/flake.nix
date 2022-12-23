{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.18?dir=dev;
    coder.url = github:defn/pkg/coder-0.13.5-0?dir=coder;
    codeserver.url = github:defn/pkg/codeserver-4.9.1-3?dir=codeserver;
    terraform.url = github:defn/pkg/terraform-1.3.4?dir=terraform;
    latest.url = github:NixOS/nixpkgs?rev=4938e72add339f76d795284cb5a3aae85d02ee53;
  };

  outputs = inputs:
    { main = inputs.dev.main; } // inputs.dev.main rec {
      inherit inputs;

      src = builtins.path { path = ./.; name = config.slug; };

      config = rec {
        slug = builtins.readFile ./SLUG;
        version = builtins.readFile ./VERSION;
      };

      handler = { pkgs, wrap, system, builders }: rec {
        defaultPackage = wrap.nullBuilder {
          propagatedBuildInputs = wrap.flakeInputs ++ (with pkgs; [
            bashInteractive

            go
            gotools
            go-tools
            golangci-lint
            go-outline
            gopkgs
            delve

            nodejs-18_x
          ]) ++ (with (import inputs.latest { inherit system; }); [
            gopls
          ]);
        };

        apps = {
          coder = {
            type = "app";
            program = "${inputs.coder.defaultPackage.${system}}/bin/coder";
          };
          codeserver = {
            type = "app";
            program = "${inputs.codeserver.defaultPackage.${system}}/bin/code-server";
          };
        };
      };
    };
}
