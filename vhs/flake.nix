{
  inputs.pkg.url = github:defn/pkg/0.0.141;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/charmbracelet/vhs/releases/download/v${input.vendor}/vhs_${input.vendor}_${input.os}_${input.arch}.tar.gz";

    installPhase = { src }: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 vhs $out/bin/vhs
    '';

    downloads = {
      options = { };

      "x86_64-linux" = {
        os = "Linux";
        arch = "x86_64";
        sha256 = "sha256-5fM5t6Zf1bPebwLoeqcdUDVKUuclMZLSbq3IWFl++0k="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "Linux";
        arch = "arm64";
        sha256 = "sha256-X9wiE4kDG4paLv0s87Dg0MB3pm8fms7atG0s1igWyWI="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "Darwin";
        arch = "x86_64";
        sha256 = "sha256-ELn0vSS0rkreEUk26UcV8XK3Z/lpn/3ROW/DYal3UL0="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "Darwin";
        arch = "arm64";
        sha256 = "sha256-ZzRYqlUCfRYGgmgCDtsITyjAcn442pONeCV00/0Heow="; # aarch64-darwin
      };
    };
  };
}
