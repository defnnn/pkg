{
  inputs = {
    pkg.url = github:defn/pkg/0.0.157;
    k3d.url = github:defn/pkg/k3d-5.4.7-2?dir=k3d;
    kubectl.url = github:defn/pkg/kubectl-1.25.6-2?dir=kubectl;
    k9s.url = github:defn/pkg/k9s-0.27.2-3?dir=k9s;
    helm.url = github:defn/pkg/helm-3.11.1-9?dir=helm;
    kustomize.url = github:defn/pkg/kustomize-5.0.0-7?dir=kustomize;
    argo.url = github:defn/pkg/argo-3.4.5-3?dir=argo;
    argocd.url = github:defn/pkg/argocd-2.6.1-3?dir=argocd;
    argorollouts.url = github:defn/pkg/argorollouts-1.4.0-5?dir=argorollouts;
  };

  outputs = inputs: inputs.pkg.main rec {
    src = ./.;

    defaultPackage = ctx: ctx.wrap.nullBuilder {
      propagatedBuildInputs = ctx.wrap.flakeInputs;
    };
  };
}
