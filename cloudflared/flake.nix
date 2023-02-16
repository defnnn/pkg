{
  inputs.pkg.url = github:defn/pkg/0.0.142;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input:
      if input.os == "linux" then
        "https://github.com/cloudflare/cloudflared/releases/download/${input.vendor}/cloudflared-${input.os}-${input.arch}"
      else
        "https://github.com/cloudflare/cloudflared/releases/download/${input.vendor}/cloudflared-${input.os}-${input.arch}.tgz";

    installPhase = { src }: ''
      install -m 0755 -d $out $out/bin
      case "$src" in
        *.tgz)
          tar xvfz $src
          install -m 0755 cloudflared $out/bin/cloudflared
          ;;
        *)
          install -m 0755 $src $out/bin/cloudflared
          ;;
      esac
    '';

    downloads = {
      options = { dontUnpack = true; dontFixup = true; };

      "x86_64-linux" = rec {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-QfpPw/QyFMISHRAG1M//qdw7lSts3jp5RA15neZY0Tg="; # x86_64-linux
      };
      "aarch64-linux" = rec {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-A+jyKtYUZYNBVMy4ZW0g6vCnN4kXPjxw/Kvdt/G2f9E="; # aarch64-linux
      };
      "x86_64-darwin" = rec {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-R0yh1sbHP+re5Q4jyK9jgsY94LQnH8LR8poV/TFc1OQ="; # x86_64-darwin
      };
      "aarch64-darwin" = rec {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-R0yh1sbHP+re5Q4jyK9jgsY94LQnH8LR8poV/TFc1OQ="; # aarch64-darwin
      };
    };
  };
}
