{
    lib,
    config,
    pkgs,
    namespace,
    ...
}:
with lib;
with lib.${namespace}; let
    cfg = config.${namespace}.desktop.addons.waybar;
in {
    options.${namespace}.desktop.addons.waybar = with types; {
        enable = mkBoolOpt false "Whether or not to enable the Waybar desktop addon";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            waybar
            pavucontrol
            # busybox
        ];

        homelab.home.configFile."waybar/config.jsonc" = {
            source = ./config.jsonc;
            # onChange = ''
            #     ${pkgs.busybox}/bin/pkill -SIGUSR2 waybar
            # '';
        };
    };
}
