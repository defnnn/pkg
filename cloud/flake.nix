{
  inputs = {
    pkg.url = github:defn/pkg/0.0.208;
    awscli.url = github:defn/pkg/awscli-2.11.11-7?dir=awscli;
    terraform.url = github:defn/pkg/terraform-1.4.4-34?dir=terraform;
    packer.url = github:defn/pkg/packer-1.8.6-37?dir=packer;
    step.url = github:defn/pkg/step-0.23.4-37?dir=step;
  };

  outputs = inputs: inputs.pkg.main rec {
    src = ./.;

    defaultPackage = ctx: ctx.wrap.nullBuilder {
      propagatedBuildInputs =
        let
          flakeInputs = [
            inputs.awscli.defaultPackage.${ctx.system}
            inputs.terraform.defaultPackage.${ctx.system}
            inputs.packer.defaultPackage.${ctx.system}
            inputs.step.defaultPackage.${ctx.system}
          ];
        in
        flakeInputs;
    };
  };
}
