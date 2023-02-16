{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.22?dir=dev;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = builtins.readFile ./SLUG; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      vendor = builtins.readFile ./VENDOR;
      revision = builtins.readFile ./REVISION;
      version = "${vendor}-${revision}";

      url_template = input: "https://releases.hashicorp.com/vault/${input.version}/vault_${input.version}_${input.os}_${input.arch}.zip";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-9IJbrQbndoe0B+/3QjrLkjit/VRdc0XyoLuegbDEses="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-TJl+2//ofpEqHkP8P0mJ3jQYB6DtBV67h9wGwgVW9to="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-lISgDWM80JEz6vxxB+PWFaHiWeyWwEx9GuOiVkbQGAI="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-XEpAuddLus7vprTEvHgsV5g7sU4+MI5YlCsdS5XwiE8="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        unzip $src
        install -m 0755 vault $out/bin/vault
      '';
    };

    handler = { pkgs, wrap, system, builders }:
      wrap.genDownloadBuilders {
        dontUnpack = true;
        dontFixup = true;
        buildInputs = [ pkgs.unzip ];
      };
  };
}
