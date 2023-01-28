{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.22?dir=dev;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = config.slug; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      revision = builtins.readFile ./REVISION;
      vendor = builtins.readFile ./VENDOR;
      version = "${slug}-${vendor}";

      url_template = input: "https://pkgs.tailscale.com/stable/tailscale_${input.version}_${input.arch}.tgz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          arch = "amd64";
          sha256 = "sha256-oB78IOQYAzeUpXrUJ2hm235D+R0f5tJdpeoE/9Mbbc0="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          arch = "arm64";
          sha256 = "sha256-GR7A7zzyBM0KafvDoo6Y8aD89lojjG4grLEXAhe3Z2M="; # aarch64-linux
        };
        # these are actually linux, to make nix happy
        "x86_64-darwin" = {
          version = vendor;
          arch = "amd64";
          sha256 = "sha256-oB78IOQYAzeUpXrUJ2hm235D+R0f5tJdpeoE/9Mbbc0="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          arch = "arm64";
          sha256 = "sha256-GR7A7zzyBM0KafvDoo6Y8aD89lojjG4grLEXAhe3Z2M="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 */tailscale $out/bin/tailscale
        install -m 0755 */tailscaled $out/bin/tailscaled
      '';
    };

    handler = { pkgs, wrap, system, builders }:
      let
        builds = wrap.genDownloadBuilders { };
      in
      builds // {
        apps.default = {
          type = "app";
          program = "${builds.defaultPackage}/bin/tailscale";
        };

        apps.tailscaled = {
          type = "app";
          program = "${builds.defaultPackage}/bin/tailscaled";
        };
      };
  };
}
