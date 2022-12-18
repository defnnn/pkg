{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs?rev=4d2b37a84fad1091b9de401eb450aae66f1a741e;
    flake-utils.url = github:numtide/flake-utils?rev=04c1b180862888302ddfb2e3ad9eaa63afc60cf8;

    wrapper = {
      url = github:defn/pkg/wrapper-0.0.12?dir=wrapper;
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = inputs:
    let
      prelude = rec {
        wrapper = inputs.wrapper;

        eachDefaultSystem = wrapper.flake-utils.lib.eachDefaultSystem;

        main = { inputs, config, handler, src }: eachDefaultSystem (system:
          let
            pkgs = inputs.nixpkgs;

            wrap = wrapper.wrap { other = inputs; inherit system; site = config; };

            handled = handler
              {
                inherit pkgs;
                inherit wrap;
                inherit system;
              };

            defaults = {
              slug = config.slug;
              devShell = wrap.devShell { };
            };
          in
          defaults // handled
        );
      };
    in
    prelude.main rec {
      inherit inputs;

      src = builtins.path { path = ./.; name = config.slug; };

      config = rec {
        slug = builtins.readFile ./SLUG;
        version = builtins.readFile ./VERSION;
        vendor = builtins.readFile ./VENDOR;

        url_template = input: "https://github.com/traefik/yaegi/releases/download/v${input.version}/yaegi_v${input.version}_${input.os}_${input.arch}.tar.gz";

        downloads = {
          "x86_64-linux" = {
            version = vendor;
            os = "linux";
            arch = "amd64";
            sha256 = "sha256-84gIbpT6fYxM3hatsggZQPITocxZjXaxLJd5F1nPYBc"; # x86_64-linux
          };
          "aarch64-linux" = {
            version = vendor;
            os = "linux";
            arch = "arm64";
            sha256 = "sha256-cRodFRlMELT8jOoYEx/XCD/9zIMrZetwbobWXtWrTIY"; # aarch64-linux
          };
          "x86_64-darwin" = {
            version = vendor;
            os = "darwin";
            arch = "amd64";
            sha256 = "sha256-kvHOz8eDV0+2+eWelsgsiCUtR863s5A//OKuvdpTdc4"; # x86_64-darwin
          };
          "aarch64-darwin" = {
            version = vendor;
            os = "darwin";
            arch = "arm64";
            sha256 = "sha256-4y6ibjkfhsgn1xQRr8pO2JpYYp1atkT7G/YXnDQg/h4"; # aarch64-darwin
          };
        };

        installPhase = { src }: ''
          install -m 0755 -d $out $out/bin
          install -m 0755 yaegi $out/bin/yaegi
        '';
      };

      handler = { pkgs, wrap, system, builders }:
        wrap.genDownloadBuilders { };
    };
}
