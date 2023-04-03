{
  inputs = {
    pkg.url = github:defn/pkg/0.0.194;
  };

  outputs = inputs: inputs.pkg.main rec {
    src = ./.;

    defaultPackage = ctx: ctx.wrap.nullBuilder {
      propagatedBuildInputs = with ctx.pkgs; [
        easyrsa
        openvpn
        wireguard-tools
        wireguard-go
      ];
    };
  };
}
