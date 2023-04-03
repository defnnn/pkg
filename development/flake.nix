{
  inputs = {
    pkg.url = github:defn/pkg/0.0.180;
    latest.url = github:NixOS/nixpkgs?rev=8ad5e8132c5dcf977e308e7bf5517cc6cc0bf7d8; # nixos-unstable https://lazamar.co.uk/nix-versions/
  };

  outputs = inputs: inputs.pkg.main rec {
    src = ./.;

    defaultPackage = ctx: ctx.wrap.nullBuilder {
      propagatedBuildInputs = with (import inputs.latest { system = ctx.system; }); [
        gnumake
        git
        git-lfs
        pre-commit
        bazel_6
        bazel-gazelle
      ];
    };
  };
}
