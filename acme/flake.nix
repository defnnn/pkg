{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.8?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "acme";
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://raw.githubusercontent.com/acmesh-official/acme.sh/v${input.version}/acme.sh";

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 $src $out/bin/acme.sh
      '';

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          sha256 = "sha256-T3a/X9Gc7sSD1KwAFYhJbOEihtquNgrtknd4bhXIVKk="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          sha256 = "sha256-T3a/X9Gc7sSD1KwAFYhJbOEihtquNgrtknd4bhXIVKk="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          sha256 = "sha256-T3a/X9Gc7sSD1KwAFYhJbOEihtquNgrtknd4bhXIVKk="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          sha256 = "sha256-T3a/X9Gc7sSD1KwAFYhJbOEihtquNgrtknd4bhXIVKk="; # aarch64-darwin
        };
      };
    };

    handler = { pkgs, wrap, system }: rec {
      devShell = wrap.devShell { };
      defaultPackage = wrap.downloadBuilder { dontUnpack = true; };

      apps.default = {
        type = "app";
        program = "${defaultPackage}/bin/acme.sh";
      };
    };
  };
}
