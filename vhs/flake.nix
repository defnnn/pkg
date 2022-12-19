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

      url_template = input: "https://github.com/charmbracelet/vhs/releases/download/v${input.version}/vhs_${input.version}_${input.os}_${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "Linux";
          arch = "x86_64";
          sha256 = "sha256-KWeyWZeOt82pmMCpJ9NMIkOKaiMrCSa5XZhMHRSSIpU="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "Linux";
          arch = "arm64";
          sha256 = "sha256-NK/m0d6RkP40GGcVuxnSSYZnYnjCyUNqWwusAr+bMvc="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "Darwin";
          arch = "x86_64";
          sha256 = "sha256-KjTBzXzd2vEQ9zyJJtDGWipoYSKIZxo/hlWgNw74RRI="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "Darwin";
          arch = "arm64";
          sha256 = "sha256-M903PFznHRt1ikUJCxN+etHzEE/EjEn1Gle3Lj/kpuc="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 vhs $out/bin/vhs
      '';
    };

    handler = { pkgs, wrap, system, builders }:
      wrap.genDownloadBuilders { };
  };
}
