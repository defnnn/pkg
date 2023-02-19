{
  inputs.pkg.url = github:defn/pkg/0.0.158;
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
        sha256 = "sha256-9ETOkA8WYQNEIzDzGnuRoNtS57HFwgyyssKIwjRHuEU="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "Linux";
        arch = "arm64";
        sha256 = "sha256-c6opqw2Gjl5icjjTorblJKQRI8qAJAS+hQ3H9vUKlWE="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "Darwin";
        arch = "x86_64";
        sha256 = "sha256-S0C0spCHPTzSjK8EUQIo0FmjS66lTTyXiSgrjTFOwEo="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-JtXaTqFNpv5F7hUykVlNjRZef6k8JppWfFLy+QPNpbE="; # x86_64-darwin
      };
    };
  };
}
