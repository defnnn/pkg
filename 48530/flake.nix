{
  inputs = {
    dev.url = github:defn/pkg?dir=dev&ref=dev-0.0.2;
    elasticsearch.url = github:defn/pkg?dir=elasticsearch&ref=elasticsearch-8.5.2;
    kibana.url = github:defn/pkg?dir=kibana&ref=kibana-8.5.2;
    filebeat.url = github:defn/pkg?dir=filebeat&ref=filebeat-8.5.2-1;
    caddy.url = github:defn/pkg?dir=caddy&ref=caddy-2.6.2;
    latest.url = github:NixOS/nixpkgs/nixpkgs-unstable;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    config = rec {
      slug = "48530";
      version = "0.0.1";
      homepage = "https://github.com/defn/pkg/tree/master/${slug}";
      description = "${slug}";
    };

    handler = { pkgs, wrap, system }: rec {
      slug = config.slug;

      latest = import inputs.latest { inherit system; };

      devShell = wrap.devShell;
      defaultPackage = wrap.nullBuilder {
        propagatedBuildInputs = wrap.flakeInputs ++
          [ latest.nomad ];
      };
    };
  };
}
