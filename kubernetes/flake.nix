{
  inputs = {
    pkg.url = github:defn/pkg/0.0.170;
    k3d.url = github:defn/pkg/k3d-5.4.9-0?dir=k3d;
    kubectl.url = github:defn/pkg/kubectl-1.25.8-0?dir=kubectl;
    k9s.url = github:defn/pkg/k9s-0.27.3-2?dir=k9s;
    helm.url = github:defn/pkg/helm-3.11.2-3?dir=helm;
    kustomize.url = github:defn/pkg/kustomize-5.0.1-0?dir=kustomize;
    argocd.url = github:defn/pkg/argocd-2.6.6-0?dir=argocd;
    kn.url = github:defn/pkg/kn-1.9.1-2?dir=kn;
    vcluster.url = github:defn/pkg/vcluster-0.14.2-0?dir=vcluster;
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
            inputs.kn.defaultPackage.${ctx.system}
            inputs.vcluster.defaultPackage.${ctx.system}
          ];
        in
        flakeInputs;
    };
  };
}
