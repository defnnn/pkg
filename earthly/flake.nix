{
  inputs.pkg.url = github:defn/pkg/0.0.159;
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
        sha256 = "sha256-HPznrbFj8L0OEWVZHtIMRIHqDnVywd4740vEetieWpI="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-LJoO6KxFvBKqVwKHtUcnmKGHJp8BEs0wG5NpjMo6TGs="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-9jtxuHb3gO+w1NgFk9a4rqP5SQt+f4UDElzfPnBCflI="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-EsYGdcvfXH6iKoyVd2zX8cZKFJcnUbVnz7EUUE9dph0="; # aarch64-darwin
      };
    };
  };
}
