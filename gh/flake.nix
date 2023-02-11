{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.22?dir=dev;
  };

  outputs = inputs: inputs.dev.main rec {
    inherit inputs;

    src = builtins.path { path = ./.; name = builtins.readFile ./SLUG; };

    config = rec {
      slug = builtins.readFile ./SLUG;
      vendor = builtins.readFile ./VENDOR;
      revision = builtins.readFile ./REVISION;
      version = "${vendor}-${revision}";

      url_template = input: "https://github.com/cli/cli/releases/download/v${input.version}/gh_${input.version}_${input.os}_${input.arch}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-d0xKsW6WL4UWZBYuTV6+b+KnuBQ6+vGi67/RFfBRfaA="; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-LzthWie/SVQCzWElJuurEj0LDrcCYkR+wB41fYmYHTk="; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "macos";
          arch = "amd64";
          sha256 = "sha256-sIB9Xw2vz6j6LJEb62PPP/vGlYooL8yYVF3J2QcP5LY="; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "macos";
          arch = "amd64"; # no arm64 macos
          sha256 = "sha256-sIB9Xw2vz6j6LJEb62PPP/vGlYooL8yYVF3J2QcP5LY="; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 */bin/gh $out/bin/gh
      '';
    };

    handler = { pkgs, wrap, system, builders }:
      wrap.genDownloadBuilders { };
  };
}
