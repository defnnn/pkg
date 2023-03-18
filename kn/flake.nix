{
  inputs.pkg.url = github:defn/pkg/0.0.170;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/knative/client/releases/download/knative-v${input.vendor}/kn-${input.os}-${input.arch}";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 $src $out/bin/kn
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
        sha256 = "sha256-0hPm5Ur+Dar0oQsGLJiBA/+orZ5zkjuGVxs8fri72YQ="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-uiAxl3JbVkbFszXPaKWztL3KdBOaL/xKhjTqS60WgMI="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-/MWQzMYSJFLzhkHRJYzAmuRRlZZvz9DTrSycwftgkyk="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-6RJhCBRbgtuvQolG9PXiViHJlKnZRHpXlgdxRAYUAKA="; # aarch64-darwin
      };
    };
  };
}
