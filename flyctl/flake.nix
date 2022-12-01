{
  inputs = {
    dev.url = github:defn/pkg/dev-0.0.4?dir=dev;
  };

  outputs = inputs: inputs.dev.main {
    inherit inputs;

    config = rec {
      slug = "flyctl";
      version = "0.0.435";



      url_template = input: "https://github.com/superfly/flyctl/releases/download/v${input.version}/flyctl_${input.version}_${input.os}_${input.arch}.tar.gz";

      installPhase = { src }: ''
        install -m 0755 -d $out $out/bin
        install -m 0755 flyctl $out/bin/flyctl
      '';

      downloads = {
        "x86_64-linux" = {
          version = vendor;
          os = "Linux";
          arch = "x86_64";
          sha256 = "sha256-hMQ+wcYvdnGnWYTl67Jge9Ei3LcpXhjDQnP7M3VzU9I";
        };
        "aarch64-linux" = {
          version = vendor;
          os = "Linux";
          arch = "arm64";
          sha256 = "sha256-arOHq2kurbji3jOzaCr42htOnWmwp9GtnYHbU3bLpHQ";
        };
        "x86_64-darwin" = {
          version = vendor;
          os = "macOS";
          arch = "x86_64";
          sha256 = "sha256-U1hvuZtNA6PWB9MvLcYZbzl0pp7856rLWDuwPx8Ba/M";
        };
        "aarch64-darwin" = {
          version = vendor;
          os = "macOS";
          arch = "arm64";
          sha256 = "sha256-JEGsWl6/Q3pkX21yLy7X8cdD/GXbVcqQxn6qenUe82w";
        };
      };
    };

    handler = { pkgs, wrap, system }: {
      devShell = wrap.devShell;
      defaultPackage = wrap.downloadBuilder { };
    };
  };
}
