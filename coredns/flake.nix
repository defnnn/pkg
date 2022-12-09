{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10-rc3?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "coredns";
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://github.com/coredns/coredns/releases/download/v${input.version}/coredns_${input.version}_${input.os}_${input.arch}.tgz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "x86_64";
          sha256 = "sha256-aaaH7m+cKH6wBif+vjeKDzj+9NrzkVnEzHX3GcVcVpg="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-S0YXRu4fD4d8BSwjoJxDqb4S/+kVXmhiPBaQSq5tJ3w="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-/VRbqH6pnAwVuDRPhwWl/DJXSGEYrw/4HzXAUslXuJk="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-/VRbqH6pnAwVuDRPhwWl/DJXSGEYrw/4HzXAUslXuJk="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 coredns $out/bin/coredns
      '';
    };

    handler = { pkgs, wrap, system }:
      wrap.genDownloadBuilders { };
  };
}
