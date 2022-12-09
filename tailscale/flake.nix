{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10-rc2?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "tailscale";
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://pkgs.tailscale.com/stable/tailscale_${input.version}_${input.arch}.tgz";

      downloads = rec {
        "x86_64-linux" = {
          version = vendor;
          arch = "amd64";
          sha256 = "sha256-QI/Z6SoKCGxinyY8yS2WKJh4MzCk0EEYoWagMOACYRw="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          arch = "arm64";
          sha256 = "sha256-EwRebixL8fEoQdrnu0Y0ku3YtQyJpWl/aU9k8kFw+Is="; # aarch64-linux
        };
        # these are actually linux, to make nix happy
        "x86_64-darwin" = {
          version = vendor;
          arch = "amd64";
          sha256 = "sha256-QI/Z6SoKCGxinyY8yS2WKJh4MzCk0EEYoWagMOACYRw="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          arch = "arm64";
          sha256 = "sha256-EwRebixL8fEoQdrnu0Y0ku3YtQyJpWl/aU9k8kFw+Is="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 */tailscale $out/bin/tailscale
        install -m 0755 */tailscaled $out/bin/tailscaled
      '';
    };

    handler = { pkgs, wrap, system }:
      let
        commonBuild = { };
        builds = wrap.genDownloadBuilders commonBuild;
      in
      builds // {
        devShell = wrap.devShell { };

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
