{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.4?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "tailscale";
      version_src = ./VERSION;
      version = builtins.readFile version_src;
      vendor_src = ./VENDOR;
      vendor = builtins.readFile vendor_src;

      url_template = input: "https://pkgs.tailscale.com/stable/tailscale_${input.version}_${input.arch}.tgz";

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 */tailscale $out/bin/tailscale
        install -m 0755 */tailscaled $out/bin/tailscaled
      '';

      downloads = rec {
        "x86_64-linux" = {
          version = vendor;
          arch = "amd64";
          sha256 = "sha256-0df84XteB2mCtpHWOabyhEzw+tBtTO5suN+4hjIDM0I=";
        };
        "aarch64-linux" = {
          version = vendor;
          arch = "arm64";
          sha256 = "sha256-OZLnrM/nl+AxGKDQmj1rd9zpBWsXCGC8ntILxmF4h3w=";
        };
        # these are actually linux, to make nix happy
        "x86_64-darwin" = {
          version = vendor;
          arch = "amd64";
          sha256 = "sha256-0df84XteB2mCtpHWOabyhEzw+tBtTO5suN+4hjIDM0I=";
        };
        "aarch64-darwin" = {
          version = vendor;
          arch = "arm64";
          sha256 = "sha256-OZLnrM/nl+AxGKDQmj1rd9zpBWsXCGC8ntILxmF4h3w=";
        };
      };
    };

    handler = { pkgs, wrap, system }: rec {
      devShell = wrap.devShell;
      defaultPackage = wrap.downloadBuilder { };

      apps.default = {
        type = "app";
        program = "${defaultPackage}/bin/tailscale";
      };

      apps.tailscaled = {
        type = "app";
        program = "${defaultPackage}/bin/tailscaled";
      };
    };
  };
}
