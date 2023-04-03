{
  inputs.pkg.url = github:defn/pkg/0.0.196;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/stern/stern/releases/download/v${input.vendor}/stern_${input.vendor}_${input.os}_${input.arch}.tar.gz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 stern $out/bin/stern
    '';

    downloads = {
      

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-PJnba2XlOx5PNSEMIf5jm4aQOl9w5ocv1MeZuo049mA="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-8TaCt1bOkLwG7WwPKBDFncuVH7EX2lwCKsrcqwwDyF4="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-I5ekK3P85Ebdm9Z5UdKUWmoikn3ewztydn/qtxb3O3Q="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-Rq6YnUDl3T/zcvRELjl7Jg7jrPuYvGwmRsnBHzfUrV8="; # aarch64-darwin
      };
    };
  };
}
