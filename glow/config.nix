rec {
  slug = "defn-pkg-glow";
  version = "1.4.1";
  homepage = "https://defn.sh/${slug}";
  description = "charmbracelet glow";
  url_template = input: "https://github.com/charmbracelet/glow/releases/download/v${input.version}/glow_${input.version}_${input.os}_${input.arch}.tar.gz";
  downloads = {
    "x86_64-linux" = rec {
      inherit version;
      os = "linux";
      arch = "x86_64";
      sha256 = "sha256-q3tM+a5uINbImGiMXzOHYpf57wRhbLzv+OA3nfnQYyE=";
    };
    "aarch64-linux" = rec {
      inherit version;
      os = "linux";
      arch = "arm64";
      sha256 = "sha256-K1LJVGyxXb9gzJTVobSuyoMNIR+uRVLiWg/oiMkU9qc=";
    };
    "x86_64-darwin" = rec {
      inherit version;
      os = "darwin";
      arch = "x86_64";
      sha256 = "sha256-K1LJVGyxXb9gzJTVobSuyoMNIR+uRVLiWg/oiMkU9qc=";
    };
    "aarch64-darwin" = rec {
      inherit version;
      os = "darwin";
      arch = "x86_64";
      sha256 = " sha256-K1LJVGyxXb9gzJTVobSuyoMNIR+uRVLiWg/oiMkU9qc=";
    };
  };
}
