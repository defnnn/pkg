{
  inputs = {
    pkg.url = github:defn/pkg/0.0.172;
  };

  outputs = inputs: inputs.pkg.main rec {
    src = ./.;

    defaultPackage = ctx: ctx.wrap.nullBuilder {
      propagatedBuildInputs = with ctx.pkgs; [
        xz
        unzip
        rsync
        dnsutils
        nettools
        htop
        wget
        curl
        procps
      ];
    };
  };
}
