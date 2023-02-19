{
  inputs.pkg.url = github:defn/pkg/0.0.159;
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
        sha256 = "sha256-9etKMKWWe91a8d5RkN2HKpHuaSPGseqlgDjwObgiTTg="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-Zqz5JrbW64rgzXh5tK0ZBwkIW935aNbxiek+pWFd5uE="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-ZYtSK+TVO4N5hdio/YvWhfBx0pjGYIucVNKsoL0w/A8="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-osWAU0QyFHXgutuQ0dPJ3bsV+kcRXiEtioh97Tu4CK4="; # aarch64-darwin
      };
    };
  };
}
