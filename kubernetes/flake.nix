{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.22?dir=dev;
    k3d.url = github:defn/pkg/k3d-5.4.7-0?dir=k3d;
    kubectl.url = github:defn/pkg/kubectl-1.25.6-0?dir=kubectl;
    k9s.url = github:defn/pkg/k9s-0.27.2-0?dir=k9s;
    helm.url = github:defn/pkg/helm-3.11.1-0?dir=helm;
    kustomize.url = github:defn/pkg/kustomize-5.0.0-0?dir=kustomize;
    argo.url = github:defn/pkg/argo-3.4.5-0?dir=argo;
    argocd.url = github:defn/pkg/argocd-2.6.1-0?dir=argocd;
    argorollouts.url = github:defn/pkg/argorollouts-1.4.0-2?dir=argorollouts;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = builtins.readFile ./SLUG; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      version = builtins.readFile ./VERSION;
    };

    handler = { pkgs, wrap, system, builders }: rec {
      defaultPackage = wrap.nullBuilder {
        propagatedBuildInputs = wrap.flakeInputs;
      };
    };
  };
}
