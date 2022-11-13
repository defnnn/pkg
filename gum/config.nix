rec {
  slug = "defn-pkg-gum";
  version = "0.8.0";
  homepage = "https://defn.sh/${slug}";
  description = "chamrbracelet gum";

  url_template = input: "https://github.com/charmbracelet/gum/releases/download/v${input.version}/gum_${input.version}_${input.os}_${input.arch}.tar.gz";

  downloads = {
    "x86_64-linux" = rec {
      inherit version;
      os = "linux";
      arch = "x86_64";
      sha256 = "sha256-K1LJVGyxXb9gzJTVobSuyoMNIR+uRVLiWg/oiMkU9qc=";
    };
  };

  installPhase = { src }: ''
    install -m 0755 -d $out $out/bin
    install -m 0755 gum $out/bin/gum
  '';
}

