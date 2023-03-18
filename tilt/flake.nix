{
  inputs.pkg.url = github:defn/pkg/0.0.168;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/tilt-dev/tilt/releases/download/v${input.vendor}/tilt.${input.vendor}.${input.os}.${input.arch}.tar.gz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 tilt $out/bin/tilt
    '';

    downloads = {
      

      "x86_64-linux" = {
        os = "linux";
        arch = "x86_64";
        sha256 = "sha256-nsGiGTkzZ/xB3V9fEIP2DW6YOeWCG4FwwmSBv2sZ3H4="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-ig/KOynkgr08WPwXd+S+BfUIcjpkgklIeKJ199Wn8sE="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "mac";
        arch = "x86_64";
        sha256 = "sha256-reCHfnL1agiTd+UX78hjaSIKx7aoHweOjpmpwpqiROs="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "mac";
        arch = "arm64";
        sha256 = "sha256-2h1bSzspBY1682izyTWksdsrHyXavNlfwcQzA65zZf0="; # aarch64-darwin
      };
    };
  };
}
