{
  inputs.pkg.url = github:defn/pkg/0.0.166;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://releases.hashicorp.com/terraform/${input.vendor}/terraform_${input.vendor}_${input.os}_${input.arch}.zip";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      unzip $src
      install -m 0755 terraform $out/bin/terraform
    '';

    downloads = {
      options = pkg: {
        dontUnpack = true;
        dontFixup = true;
        buildInputs = with pkg.ctx.pkgs; [ unzip ];
      };

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-sJ8VRghrX7d4XhTZQH3PKjthWOjvOzTpjIn7+hkSX8s="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-uqoU2cSEpEKALJmFS6LGI/mjfH00dJyg0A9+n70gu+Q="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-sv7KlGjjrlDVMEi7q5ipTsMjWUAJsvqbej9HOXSc2IM="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-nn4nOq+1JO+6a4SflRTCN0NCFcGkgZ6KrcL6sI/ii4I="; # aarch64-darwin
      };
    };
  };
}
