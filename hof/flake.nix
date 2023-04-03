{
  inputs.pkg.url = github:defn/pkg/0.0.197;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/hofstadter-io/hof/releases/download/v${input.vendor}/hof_${input.vendor}_${input.os}_${input.arch}";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 $src $out/bin/hof
    '';

    downloads = {
      options = pkg: { dontUnpack = true; };

      "x86_64-linux" = {
        os = "Linux";
        arch = "x86_64";
        sha256 = "sha256-RDi87muYLkxIPH5mHg8jzFkTZLJo0DFytXscIGmlekQ="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "Linux";
        arch = "arm64";
        sha256 = "sha256-4GdksRjuZiMRNkTUKKLz/70hTlDl1HcIGQVe8E50q+Y="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "Darwin";
        arch = "x86_64";
        sha256 = "sha256-IbDHK9uMsT4oReRY75XwxJj7uFFQTDiVB4Ao8gDJIGE="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "Darwin";
        arch = "arm64";
        sha256 = "sha256-Uhc3y96pDQ+lJHUodng2fKK03BdVaZvXaNpJlzOBGxM="; # aarch64-darwin
      };
    };
  };
}
