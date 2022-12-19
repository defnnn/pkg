{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.17?dir=dev;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = config.slug; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://pkgs.tailscale.com/stable/tailscale_${input.version}_${input.arch}.tgz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          arch = "amd64";
          sha256 = "sha256-w2Ygs/IZAcx3ZMOOkXGRuCMHNqNW0zX4AGL3MRrlp9o="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          arch = "arm64";
          sha256 = "sha256-6FI8ru8YIwDEdsjz6hLu39wI0Bv963i9+GTy5+mIi/0="; # aarch64-linux
        };
        # these are actually linux, to make nix happy
        "x86_64-darwin" = {
          version = vendor;
          arch = "amd64";
          sha256 = "sha256-w2Ygs/IZAcx3ZMOOkXGRuCMHNqNW0zX4AGL3MRrlp9o="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          arch = "arm64";
          sha256 = "sha256-6FI8ru8YIwDEdsjz6hLu39wI0Bv963i9+GTy5+mIi/0="; # aarch64-darwin
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
