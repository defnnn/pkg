{
  inputs.pkg.url = github:defn/pkg/0.0.187;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://releases.hashicorp.com/packer/${input.vendor}/packer_${input.vendor}_${input.os}_${input.arch}.zip";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      unzip $src
      install -m 0755 packer $out/bin/packer
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
        sha256 = "sha256-V9BBHleK6mKRjTbtGGlRE51dSdRLduVmbR+/JCezha4="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-byit4AQPpA/bGZZru4fd3FsonXqpDGUDY41huq6lTRk="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-BkcDhWGsFOh7roHleNV1dVWYNG7T4nKsmMspScpM2FI="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-10l/G6PGIh/rSjipYGJq+8TrJlUvxA2UG/9XzCuDvVk="; # aarch64-darwin
      };
    };
  };
}
