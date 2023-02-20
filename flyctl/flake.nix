{
  inputs.pkg.url = github:defn/pkg/0.0.159;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/superfly/flyctl/releases/download/v${input.vendor}/flyctl_${input.vendor}_${input.os}_${input.arch}.tar.gz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 flyctl $out/bin/flyctl
    '';

    downloads = {
      

      "x86_64-linux" = {
        os = "Linux";
        arch = "x86_64";
        sha256 = "sha256-5fMKAOQIhecvwwE0UbWAPkVaUr5Uw02Cnskotq5dkVE="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "Linux";
        arch = "arm64";
        sha256 = "sha256-W3u+hpk9uhFaPHah3G9sPU4CLirQb5wGZTtqb0d2gMY="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "macOS";
        arch = "x86_64";
        sha256 = "sha256-4Zs7vkaeniz0D8pxnPFnUaqMGk5FGB21nnyjNW6Fnsw="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "macOS";
        arch = "arm64";
        sha256 = "sha256-w5+xnsJl3VqFCN3+LDTsDb0+Xn8jE3I7gXi1yLrlIDs="; # aarch64-darwin
      };
    };
  };
}
