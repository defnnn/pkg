{
  inputs.pkg.url = github:defn/pkg/0.0.183;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    # https://cloud.google.com/sdk/docs/install#linux
    url_template = input: "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-${input.vendor}-${input.os}-${input.arch}.tar.gz";

    installPhase = pkg: ''
      mkdir -p $out
      cp -rp google-cloud-sdk/. $out/
    '';

    downloads = {
      options = pkg: {
        dontFixup = true;
      };

      "x86_64-linux" = rec {
        os = "linux";
        arch = "x86_64";
        sha256 = "sha256-971+/UPHlDZ/YHfUsuzwBVBCN79MNXib8qXPqXAdbFE="; # x86_64-linux
      };
      "aarch64-linux" = rec {
        os = "linux";
        arch = "arm";
        sha256 = "sha256-w+H7vcXirN6hv1A/jCjwvcW92rLART5YCCP1cl19RJs="; # aarch64-linux
      };
      "x86_64-darwin" = rec {
        os = "darwin";
        arch = "arm";
        sha256 = "sha256-pH6eUqdRTVYkMzp9MewEBI9vQJvegQOdo4ajfwQbdwY="; # x86_64-darwin
      };
      "aarch64-darwin" = rec {
        os = "darwin";
        arch = "arm";
        sha256 = "sha256-pH6eUqdRTVYkMzp9MewEBI9vQJvegQOdo4ajfwQbdwY="; # aarch64-darwin
      };
    };
  };
}
