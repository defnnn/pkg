{
  inputs = {
    pkg.url = github:defn/pkg/0.0.194;
    k3d.url = github:defn/pkg/k3d-5.4.9-22?dir=k3d;
    kubectl.url = github:defn/pkg/kubectl-1.25.8-22?dir=kubectl;
    k9s.url = github:defn/pkg/k9s-0.27.3-24?dir=k9s;
    helm.url = github:defn/pkg/helm-3.11.2-25?dir=helm;
    kustomize.url = github:defn/pkg/kustomize-5.0.1-22?dir=kustomize;
    stern.url = github:defn/pkg/stern-1.24.0-23?dir=stern;
    argo.url = github:defn/pkg/argo-3.4.6-22?dir=argo;
    argocd.url = github:defn/pkg/argocd-2.6.7-23?dir=argocd;
    tkn.url = github:defn/pkg/tkn-0.30.0-24?dir=tkn;
    kn.url = github:defn/pkg/kn-1.9.2-23?dir=kn;
    vcluster.url = github:defn/pkg/vcluster-0.14.2-22?dir=vcluster;
  };

  outputs = inputs: inputs.pkg.main rec {
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
