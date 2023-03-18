{
  inputs.pkg.url = github:defn/pkg/0.0.167;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/earthly/earthly/releases/download/v${input.vendor}/earthly-${input.os}-${input.arch}";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 $src $out/bin/earthly
    '';

    downloads = {
      options = pkg: {
        dontUnpack = true;
      };

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-7XagCE5hWwSwPdHXQJ6PbG9K7w6gOqyleRI9lhrIvYE="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-RZ3/h3GZzUpNQcF9OZJw8tTOsZvvdqshCpnaPEtbEEs="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-gW/99vBTSgptgds2ZdZTThWIcGhVzaMptnVBEJ3PRwk="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-bAkWyLTGpdKqxfhxRbKqfodxgOMGXax3RRDN+2+HIps="; # aarch64-darwin
      };
    };
  };
}
