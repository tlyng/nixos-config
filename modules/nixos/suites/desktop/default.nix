{
    lib,
    config,
    pkgs,
    namespace,
    ...
}:
with lib;
with lib.${namespace}; let
    cfg = config.${namespace}.suites.desktop;
in {
    options.${namespace}.suites.desktop = with types; {
        enable = mkBoolOpt false "Whether or not to enable the desktop suite";
    };

    config = mkIf cfg.enable {
        homelab = {
            desktop.hyprland.enable = true;
            apps.terminals.enable = true;
        };
    };
}
