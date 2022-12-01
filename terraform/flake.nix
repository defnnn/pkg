{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.4?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "terraform ";
      version_src = ./VERSION;
      version = builtins.readFile version_src;
      vendor_src = ./VENDOR;
      vendor = builtins.readFile vendor_src;

      url_template = input: "https://releases.hashicorp.com/terraform/${input.version}/terraform_${input.version}_${input.os}_${input.arch}.zip";

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        unzip $src
        install -m 0755 terraform $out/bin/terraform
      '';

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "linux";
          arch = "amd64";
          sha256 = "sha256-u0SkwrCoMtSSU7kDTYzL00+f7rJu2nHGZfbn+ghh9Js=";
        };
        "aarch64-linux" = {
          version = vendor;
          os = "linux";
          arch = "arm64";
          sha256 = "sha256-9LGvKQlCkPGzk1wpAzxOUpFmTuLAFcolGgIN1CXIR8M=";
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "amd64";
          sha256 = "sha256-WrmOLZ87kI/WQioFYugpzBfrBVyOJCQn0W0KE1BtQBs=";
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "darwin";
          arch = "arm64";
          sha256 = "sha256-8cILIYDJgr3ag4SxMWIJ0g/FXe9PA1Tq16Ko4EyJ9U4=";
        };
      };
    };

    handler = { pkgs, wrap, system }: {
      devShell = wrap.devShell;
      defaultPackage = wrap.downloadBuilder {
        dontUnpack = true;
        buildInputs = [ pkgs.unzip ];
      };
    };
  };
}
