{
  inputs = {
    terraform.url = github:defn/pkg/terraform-1.4.4-36?dir=terraform;
    packer.url = github:defn/pkg/packer-1.8.6-39?dir=packer;
    step.url = github:defn/pkg/step-0.23.4-39?dir=step;
    awscli.url = github:defn/pkg/awscli-2.11.11-10?dir=awscli;
  };

  outputs = inputs: inputs.terraform.inputs.pkg.main rec {
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
