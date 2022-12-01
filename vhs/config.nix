rec {
  slug = "defn-pkg-vhs";
  version = "0.1.1";
  
  
  url_template = input: "https://github.com/charmbracelet/vhs/releases/download/v${input.version}/vhs_${input.version}_${input.os}_${input.arch}.tar.gz";
  downloads = {
    "x86_64-linux" = {
      version = vendor;
      os = "Linux";
      arch = "x86_64";
      sha256 = "sha256-KWeyWZeOt82pmMCpJ9NMIkOKaiMrCSa5XZhMHRSSIpU=";
    };
    "aarch64-linux" = {
      version = vendor;
      os = "Linux";
      arch = "arm64";
      sha256 = "sha256-K1LJVGyxXb9gzJTVobSuyoMNIR+uRVLiWg/oiMkU9qc=";
    };
    "x86_64-darwin" = {
      version = vendor;
      os = "Darwin";
      arch = "x86_64";
      sha256 = "sha256-K1LJVGyxXb9gzJTVobSuyoMNIR+uRVLiWg/oiMkU9qc=";
    };
    "aarch64-darwin" = {
      version = vendor;
      os = "Darwin";
      arch = "x86_64";
      sha256 = " sha256-K1LJVGyxXb9gzJTVobSuyoMNIR+uRVLiWg/oiMkU9qc=";
    };
  };
}
