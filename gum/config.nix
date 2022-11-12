rec {
  slug = "defn-pkg-gum";
  version = "0.8.0";
  homepage = "https://defn.sh/${slug}";
  description = "chamrbracelet gum";
  downloads = {
    "x86_64-linux" = rec {
      url = "https://github.com/charmbracelet/gum/releases/download/v${version}/gum_${version}_linux_${arch}.tar.gz";
      arch = "x86_64";
      sha256 = "sha256-K1LJVGyxXb9gzJTVobSuyoMNIR+uRVLiWg/oiMkU9qc=";
    };
  };
}
