{
    lib,
    config,
    pkgs,
    namespace,
    ...
}:
with lib;
with lib.${namespace}; let
    cfg = config.${namespace}.desktop.hyprland;
in {
    options.${namespace}.desktop.hyprland = with types; {
        enable = mkBoolOpt false "Whether or not to enable the Hyprland desktop";
    };

    config = mkIf cfg.enable {
        programs.hyprland.enable = true;
        programs.hyprland.xwayland.enable = true;
        programs.hyprland.withUWSM = true;
        xdg.portal.enable = true;

        homelab.desktop.addons.greetd.enable = true;
        homelab.desktop.addons.waybar.enable = true;

        environment.sessionVariables.NIXOS_OZONE_WL = "1";

        environment.systemPackages = with pkgs; [
            xdg-desktop-portal-hyprland
            hyprpaper # wallpaper utility
            hyprpicker # color picker
            hyprlock # screen locker
            wl-clipboard # allows copying to wl-clipboard
            xdg-utils # allows xdg-open to work
        ];

        homelab.home.configFile = {
            "hypr/launch".source = ./launch;
            "hypr/hyprland.conf".source = ./hyprland.conf;
        };
    };
}
