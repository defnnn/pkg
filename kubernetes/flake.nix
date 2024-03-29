{
  inputs = {
    kubectl.url = github:defn/pkg/kubectl-1.25.8-36?dir=kubectl;
    k3d.url = github:defn/pkg/k3d-5.4.9-36?dir=k3d;
    k9s.url = github:defn/pkg/k9s-0.27.3-38?dir=k9s;
    helm.url = github:defn/pkg/helm-3.11.2-39?dir=helm;
    kustomize.url = github:defn/pkg/kustomize-5.0.1-36?dir=kustomize;
    stern.url = github:defn/pkg/stern-1.24.0-37?dir=stern;
    argo.url = github:defn/pkg/argo-3.4.6-36?dir=argo;
    argocd.url = github:defn/pkg/argocd-2.6.7-37?dir=argocd;
    tkn.url = github:defn/pkg/tkn-0.30.0-38?dir=tkn;
    kn.url = github:defn/pkg/kn-1.9.2-37?dir=kn;
    vcluster.url = github:defn/pkg/vcluster-0.14.2-36?dir=vcluster;
    kubevirt.url = github:defn/pkg/kubevirt-0.59.0-3?dir=kubevirt;
  };

  outputs = inputs: inputs.kubectl.inputs.pkg.main rec {
    src = ./.;

    defaultPackage = ctx: ctx.wrap.nullBuilder {
      propagatedBuildInputs =
        let
          flakeInputs = [
            inputs.k3d.defaultPackage.${ctx.system}
            inputs.kubectl.defaultPackage.${ctx.system}
            inputs.k9s.defaultPackage.${ctx.system}
            inputs.helm.defaultPackage.${ctx.system}
            inputs.kustomize.defaultPackage.${ctx.system}
            inputs.argocd.defaultPackage.${ctx.system}
            inputs.argo.defaultPackage.${ctx.system}
            inputs.tkn.defaultPackage.${ctx.system}
            inputs.kn.defaultPackage.${ctx.system}
            inputs.vcluster.defaultPackage.${ctx.system}
          ];
        in
        flakeInputs;
    };
  };
}
