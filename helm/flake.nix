{
  inputs.pkg.url = github:defn/pkg/0.0.197;
  outputs = inputs: inputs.pkg.downloadMain {
    src = ./.;

    url_template = input: "https://get.helm.sh/helm-v${input.vendor}-${input.os}-${input.arch}.tar.gz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      install -m 0755 */helm $out/bin/helm
    '';

    downloads = {
      

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-eB2Cba7FhPnVCgHw99rf0lozEiF6FKovu4UQewFKyMo="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-CmC6rIPDEGAXZmhk5mT1Kk4W+9V4rACfmoVFapJBxds="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-QEk4/Sxu/54Nq4MLDblD/KnhVyzT1+5AkEcFdg+qOQ8="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-9ho6pVgn3i2MZKIGP9dEthi0Q+0GOHG3n1IGnpCBMVE="; # aarch64-darwin
      };
    };
  };
}
