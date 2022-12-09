{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.10?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "helm";
      version = builtins.readFile ./VERSION;
      vendor = builtins.readFile ./VENDOR;

      url_template = input: "https://get.helm.sh/helm-v${input.version}-${input.os}-${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-IxWUGhMpHCd9rJ9l516tVjhkQNOQfgVAvxV65w8Yg0c"; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-V/oXtrsECjeIEWVXpyV58hgOqWILTuiptyROWQHfAuQ"; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-6ImWDkwdfi39uRsQK+z68icAy4bcPjVT2b69e6taOAM"; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-RgRB7qF2TKQ44p+g44qg0mB0AvdTy2VqSrDakiPtpJQ"; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 */helm $out/bin/helm
      '';
    };

    handler = { pkgs, wrap, system }:
      wrap.genDownloadBuilders { };
  };
}
