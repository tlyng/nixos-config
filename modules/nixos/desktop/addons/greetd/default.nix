{
    lib,
    config,
    pkgs,
    namespace,
    ...
}:
with lib;
with lib.${namespace}; let
    cfg = config.${namespace}.desktop.addons.greetd;
in {
    options.${namespace}.desktop.addons.greetd = with types; {
        enable = mkBoolOpt false "Whether or not to enable the greetd display manager";
    };

    config = mkIf cfg.enable {
        services.greetd = {
            enable = true;
            settings = rec {
                initial_session = {
                    command = "${pkgs.hyprland}/bin/Hyprland";
                    user = "${config.homelab.user.name}";
                };
                default_session = initial_session;
            };
        };
    };
}
