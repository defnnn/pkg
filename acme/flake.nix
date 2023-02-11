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
      version ="${slug}-${vendor}";

      url_template = input: "https://github.com/acmesh-official/acme.sh/archive/refs/tags/v${input.version}.tar.gz";

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          sha256 = "sha256-oZEy7WVJFAmo2Kk8Jk3LzyZakdRaRt5nSBG5P1mVOY8"; # x86_64-linux
        };
        "aarch64-linux" = {
          version = vendor;
          sha256 = "sha256-oZEy7WVJFAmo2Kk8Jk3LzyZakdRaRt5nSBG5P1mVOY8"; # aarch64-linux
        };
        "x86_64-darwin" = {
          version = vendor;
          sha256 = "sha256-oZEy7WVJFAmo2Kk8Jk3LzyZakdRaRt5nSBG5P1mVOY8"; # x86_64-darwin
        };
        "aarch64-darwin" = {
          version = vendor;
          sha256 = "sha256-oZEy7WVJFAmo2Kk8Jk3LzyZakdRaRt5nSBG5P1mVOY8"; # aarch64-darwin
        };
      };

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin $out/bin/dnsapi
        install -m 0755 */acme.sh $out/bin/acme.sh
        cp */dnsapi/* $out/bin/dnsapi/
      '';
    };

    handler = { pkgs, wrap, system, builders }:
      let
        builds = wrap.genDownloadBuilders { };
      in
      builds // {
        apps.default = {
          type = "app";
          program = "${builds.defaultPackage}/bin/acme.sh";
        };
      } // {
        defaultPackage = builds.defaultPackage // {
          sourceRoot = ".";
        };
      };
  };
}
