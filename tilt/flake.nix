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

      url_template = input: "https://github.com/tilt-dev/tilt/releases/download/v${input.version}/tilt.${input.version}.${input.os}.${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "x86_64";
          sha256 = "sha256-nsGiGTkzZ/xB3V9fEIP2DW6YOeWCG4FwwmSBv2sZ3H4="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-ig/KOynkgr08WPwXd+S+BfUIcjpkgklIeKJ199Wn8sE="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "mac";
          arch = "x86_64";
          sha256 = "sha256-reCHfnL1agiTd+UX78hjaSIKx7aoHweOjpmpwpqiROs="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "mac";
          arch = "arm64";
          sha256 = "sha256-2h1bSzspBY1682izyTWksdsrHyXavNlfwcQzA65zZf0="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 tilt $out/bin/tilt
      '';

    };

    handler = { pkgs, wrap, system, builders }:
      wrap.genDownloadBuilders { };
  };
}
