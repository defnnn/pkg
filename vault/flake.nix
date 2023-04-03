{
  inputs.pkg.url = github:defn/pkg/0.0.182;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    url_template = input: "https://releases.hashicorp.com/vault/${input.vendor}/vault_${input.vendor}_${input.os}_${input.arch}.zip";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin
      unzip $src
      install -m 0755 vault $out/bin/vault
    '';

    downloads = {
      options = pkg: {
        dontUnpack = true;
        dontFixup = true;
        buildInputs = with pkg.ctx.pkgs; [ unzip ];
      };

      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-zxAV0LMIBlFRINSoZnLqd9ofsFWeODm6iNjgLpTnlqY="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-iiR6eN1jazzcAddhL4HEz3cCYK9T5k6Qb3JqZx5vKh8="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-Hja/VFyw4LvnQHHnijQkYOOO2OlXKyIEXDyD1g+eLGY="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-mCW4f69Gfy6jkRJLVKD3UE/66p4pl4urUjE7D62ttR0="; # aarch64-darwin
      };
    };
  };
}
