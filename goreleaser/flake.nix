{
  inputs.pkg.url = github:defn/pkg/0.0.170;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://github.com/goreleaser/goreleaser/releases/download/v${input.vendor}/goreleaser_${input.os}_${input.arch}.tar.gz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 goreleaser $out/bin/goreleaser
    '';

    downloads = {
      

      "x86_64-linux" = {
        os = "linux";
        arch = "x86_64";
        sha256 = "sha256-jEWxsRiZmPLHWnDmKRA0PF6IKnvrtc2rlRVkDhPh+s8="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-JPvtMrDx9er8L8Xz5IwdJPwmaC7KIzEgg3c/EiHK5zI="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "x86_64";
        sha256 = "sha256-BGAkPhYEdKsnvw1sia1sib4Q9yrkRSIRAsshz9/ecMY="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-OqWCccOZ8jfIpfUcL+w2iof4s6Z8vLIKi/Ay8sq0bcM="; # aarch64-darwin
      };
    };
  };
}
