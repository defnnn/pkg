rec {
  slug = "defn-pkg-glow";
  version = "1.4.1";
  
  
  url_template = input: "https://github.com/charmbracelet/glow/releases/download/v${input.version}/glow_${input.version}_${input.os}_${input.arch}.tar.gz";
  downloads = {
    "x86_64-linux" = {
      version = vendor;
      os = "linux";
      arch = "x86_64";
      sha256 = "sha256-q3tM+a5uINbImGiMXzOHYpf57wRhbLzv+OA3nfnQYyE="; # x86_64-linux
    };
    "aarch64-linux" = {
      version = vendor;
      os = "linux";
      arch = "arm64";
      sha256 = "sha256-K1LJVGyxXb9gzJTVobSuyoMNIR+uRVLiWg/oiMkU9qc="; # aarch64-linux
    };
    "x86_64-darwin" = {
      version = vendor;
      os = "darwin";
      arch = "x86_64";
      sha256 = "sha256-K1LJVGyxXb9gzJTVobSuyoMNIR+uRVLiWg/oiMkU9qc="; # x86_64-darwin
    };
    "aarch64-darwin" = {
      version = vendor;
      os = "darwin";
      arch = "x86_64";
      sha256 = " sha256-K1LJVGyxXb9gzJTVobSuyoMNIR+uRVLiWg/oiMkU9qc="; # aarch64-darwin
    };
  };

  installPhase = { src }: ''
    install -m 0755 -d $out $out/bin
    install -m 0755 glow $out/bin/glow
  '';
}
