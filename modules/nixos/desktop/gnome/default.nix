{
    lib,
    config,
    pkgs,
    namespace,
    ...
}:
with lib;
with lib.${namespace}; let
    cfg = config.${namespace}.desktop.gnome;
in {
    options.${namespace}.desktop.gnome = with types; {
        enable = mkBoolOpt false "Whether or not to enable the GNOME desktop";
    };

    config = mkIf cfg.enable {
        services.xserver.enable = true;
        services.xserver.displayManager.gdm.enable = true;
        services.xserver.desktopManager.gnome.enable = true;

        programs.dconf.enable = true;
        environment.systemPackages = with pkgs; [
            xdg-desktop-portal-gnome
        ];

        xdg.portal = {
            enable = true;
            extraPortals = [
                pkgs.xdg-desktop-portal-gnome
            ];
        };

        # Install Flatpak
        services.flatpak.enable = true;

        # Gnome Keyring
        services.gnome.gnome-keyring.enable = true;

        # And ensure gnome-settings-daemon udev rules are enabled
        services.udev.packages = with pkgs; [ gnome-settings-daemon ];

        # Excluding some GNOME applications from default install
        environment.gnome.excludePackages = (with pkgs; [
            gnome-photos
            gnome-tour
            gedit
            cheese
            gnome-music
            epiphany
            geary
            gnome-characters
            gnome-weather
            totem
            tali
            iagno
            hitori
            atomix
        ]);

        services.xserver.excludePackages = (with pkgs; [
            xterm
        ]);
    };
}
