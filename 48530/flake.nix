{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.4?dir=dev;
    elasticsearch.url = github:defn/pkg/elasticsearch-8.5.2?dir=elasticsearch;
    kibana.url = github:defn/pkg/kibana-8.5.2?dir=kibana;
    filebeat.url = github:defn/pkg/filebeat-8.5.2-1?dir=filebeat;
    caddy.url = github:defn/pkg/caddy-2.6.2-1?dir=caddy;
    nomad.url = github:defn/pkg/nomad-1.4.3?dir=nomad;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "48530";
      version = builtins.readFile ./VERSION;
    };

    handler = { pkgs, wrap, system }: {
      devShell = wrap.devShell;
      defaultPackage = wrap.nullBuilder {
        propagatedBuildInputs = wrap.flakeInputs;
      };
    };
  };
}
