{
  inputs.pkg.url = github:defn/pkg/0.0.139;
  outputs = inputs: inputs.pkg.downloadMain {
    src = ./.;

    url_template = input: "https://github.com/derailed/k9s/releases/download/v${input.vendor}/k9s_${input.os}_${input.arch}.tar.gz";

    installPhase = { src }: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 k9s $out/bin/k9s
    '';

    downloads = {
      "x86_64-linux" = {
        os = "Linux";
        arch = "amd64";
        sha256 = "sha256-jUv7m/7o4oMAMFdGACACsn9HutvRniWlA9OBcgBuEXA="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "Linux";
        arch = "arm64";
        sha256 = "sha256-50UWYnfC6rfh0G/MNJLQHvpqWmvQx3oGj0eknU2OcnI="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "Darwin";
        arch = "amd64";
        sha256 = "sha256-qsMRgl99kPIOsnadfaKNP6Wc60hlLCYV3WMPd7Qe/5g="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "Darwin";
        arch = "arm64";
        sha256 = "sha256-E+cbY9pvGYdY/8WEAZHXpNnxFkV+TW8G1gFkrkNvbGQ="; # aarch64-darwin
      };
    };
  };
}
