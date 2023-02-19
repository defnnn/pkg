{
  inputs.pkg.url = github:defn/pkg/0.0.157;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/superfly/flyctl/releases/download/v${input.vendor}/flyctl_${input.vendor}_${input.os}_${input.arch}.tar.gz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 flyctl $out/bin/flyctl
    '';

    downloads = {
      

      "x86_64-linux" = {
        os = "Linux";
        arch = "x86_64";
        sha256 = "sha256-ZcWIW+zd+pHeju9264tQa3a66vO85ulvMT2buo005kk="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "Linux";
        arch = "arm64";
        sha256 = "sha256-8B24OMcV+MoEUL93qXrr+vF1fDgsa0xyvVx6gO+YzBg="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "macOS";
        arch = "x86_64";
        sha256 = "sha256-dEJdTgh2A5av15CEvE8z4sbwXJdFxI2MakEY01w/r/0="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "macOS";
        arch = "arm64";
        sha256 = "sha256-9Md5993zxKnHsYEf2I1RpJocHen9Qxwr0IgcQXOunZ4="; # aarch64-darwin
      };
    };
  };
}
