{
  inputs = {
    pkg.url = github:defn/pkg/0.0.169;
    k3d.url = github:defn/pkg/k3d-5.4.8-2?dir=k3d;
    kubectl.url = github:defn/pkg/kubectl-1.25.6-4?dir=kubectl;
    k9s.url = github:defn/pkg/k9s-0.27.3-2?dir=k9s;
    helm.url = github:defn/pkg/helm-3.11.2-3?dir=helm;
    kustomize.url = github:defn/pkg/kustomize-5.0.0-9?dir=kustomize;
    argocd.url = github:defn/pkg/argocd-argocd-2.5.5-0?dir=argocd;
    kn.url = github:defn/pkg/kn-1.9.1-2?dir=kn;
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
          ];
        in
        flakeInputs;
    };
  };
}
