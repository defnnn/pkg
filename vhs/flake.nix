{
  inputs.pkg.url = github:defn/pkg/0.0.194;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/charmbracelet/vhs/releases/download/v${input.vendor}/vhs_${input.vendor}_${input.os}_${input.arch}.tar.gz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 vhs $out/bin/vhs
    '';

    downloads = {
      

      "x86_64-linux" = {
        os = "Linux";
        arch = "x86_64";
        sha256 = "sha256-02LxrUWGozGTbmsfXeaCddvdAaYaJbVueaFOR8qU0vY="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "Linux";
        arch = "arm64";
        sha256 = "sha256-dTplys+o0NHdX8ZUVu9a29bSxfD4hbyRAenD2jH4qL8="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "Darwin";
        arch = "x86_64";
        sha256 = "sha256-B9T4pC3so9+4M0+CDPWS4N53uFMArFnAXzj0JWfRwT4="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "Darwin";
        arch = "arm64";
        sha256 = "sha256-C6Cln86iKjr+9QQh0Nt0kiGq/f3RTp/f0siqJWGLxYs="; # aarch64-darwin
      };
    };
  };
}
