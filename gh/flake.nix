{
  inputs.pkg.url = github:defn/pkg/0.0.157;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/cli/cli/releases/download/v${input.vendor}/gh_${input.vendor}_${input.os}_${input.arch}.tar.gz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 */bin/gh $out/bin/gh
    '';

    downloads = {
      

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-d0xKsW6WL4UWZBYuTV6+b+KnuBQ6+vGi67/RFfBRfaA="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-LzthWie/SVQCzWElJuurEj0LDrcCYkR+wB41fYmYHTk="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "macos";
        arch = "amd64";
        sha256 = "sha256-sIB9Xw2vz6j6LJEb62PPP/vGlYooL8yYVF3J2QcP5LY="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "macos";
        arch = "amd64"; # no arm64 macos
        sha256 = "sha256-sIB9Xw2vz6j6LJEb62PPP/vGlYooL8yYVF3J2QcP5LY="; # aarch64-darwin
      };
    };
  };
}
