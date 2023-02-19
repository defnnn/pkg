{
  inputs.pkg.url = github:defn/pkg/0.0.159;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/adnanh/webhook/releases/download/${input.vendor}/webhook-${input.os}-${input.arch}.tar.gz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 */webhook $out/bin/webhook
    '';

    downloads = {
      

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-RZGRaqhaMzKvP1cz0Ndc5OBlqhhNvae5RbslQuun2ks="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-JuPEA+7G0whFcIIBqWCtFrrHwv14u8trghppKK8Xq4A="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-xHng5y3NaUZlkS9NVp6LD91hs9kw4dTDcVao1qKgno8="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "amd64"; # no arm64
        sha256 = "sha256-xHng5y3NaUZlkS9NVp6LD91hs9kw4dTDcVao1qKgno8="; # aarch64-darwin
      };
    };
  };
}
