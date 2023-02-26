{
  inputs = {
    pkg.url = github:defn/pkg/0.0.166;
  };

  outputs = inputs: inputs.pkg.main rec {
    src = ./.;

    defaultPackage = ctx: ctx.wrap.nullBuilder {
      propagatedBuildInputs = with ctx.pkgs; [
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
