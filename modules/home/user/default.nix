{
    lib,
    config,
    pkgs,
    namespace,
    osConfig ? {},
    ...
}:
let
  inherit (lib)
    types
    mkIf
    mkDefault
    mkMerge
    ;
  inherit (lib.${namespace}) mkOpt;

  cfg = config.${namespace}.user;

  home-directory =
    if cfg.name == null then
        null
    else
        "/home/${cfg.name}";
in
{
    options.${namespace}.user = {
        enable = mkOpt types.bool true "Enable the user configuration";
        name = mkOpt (types.nullOr types.str) "torkel" "The name of the user";

        fullName = mkOpt types.str "Torkel Lyng" "The full name of the user";
        email = mkOpt types.str "me@tlyng.no" "The email of the user";

        home = mkOpt (types.nullOr types.str) home-directory "The home directory of the user";
        home-directory = mkOpt home-directory "The home directory of the user";
    };

    config = mkIf cfg.enable (mkMerge [
        {
            assertions = [
                {
                    assertion = cfg.name != null;
                    message = "homelab.user.name must be set";
                }
                {
                    assertion = cfg.home != null;
                    message = "homelab.user.home must be set";
                }
            ];

            home = {
                username = mkDefault cfg.name;
                homeDirectory = mkDefault cfg.home;
                packages = with pkgs; [
                    neofetch
                    nnn
                    ripgrep
                    jq
                    yq-go
                    eza
                    fzf
                    dnsutils
                    glow
                    btop

                ];
            };
        }
    ]);
}