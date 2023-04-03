{
  inputs = {
    pkg.url = github:defn/pkg/0.0.192;
    k3d.url = github:defn/pkg/k3d-5.4.9-19?dir=k3d;
    kubectl.url = github:defn/pkg/kubectl-1.25.8-19?dir=kubectl;
    k9s.url = github:defn/pkg/k9s-0.27.3-21?dir=k9s;
    helm.url = github:defn/pkg/helm-3.11.2-22?dir=helm;
    kustomize.url = github:defn/pkg/kustomize-5.0.1-20?dir=kustomize;
    stern.url = github:defn/pkg/stern-1.24.0-21?dir=stern;
    argo.url = github:defn/pkg/argo-3.4.6-19?dir=argo;
    argocd.url = github:defn/pkg/argocd-2.6.7-20?dir=argocd;
    tkn.url = github:defn/pkg/tkn-0.30.0-22?dir=tkn;
    kn.url = github:defn/pkg/kn-1.9.2-20?dir=kn;
    vcluster.url = github:defn/pkg/vcluster-0.14.2-20?dir=vcluster;
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
