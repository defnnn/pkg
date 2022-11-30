{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.2?dir=dev;
    elasticsearch.url = github:defn/pkg/elasticsearch-8.5.2?dir=elasticsearch;
    kibana.url = github:defn/pkg/kibana-8.5.2?dir=kibana;
    filebeat.url = github:defn/pkg/filebeat-8.5.2-1?dir=filebeat;
    caddy.url = github:defn/pkg/caddy-2.6.2?dir=caddy;
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
