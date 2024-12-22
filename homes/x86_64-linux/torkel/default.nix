{
    lib,
    pkgs,
    config,
    namespace,
    ...
}:
with lib;
with lib.${namespace};
{
    homelab = {
        user = {
            enable = true;
            name = "torkel";
        };
        cli-apps = {
            home-manager.enable = true;
            zsh.enable = true;
        };
    };

    home.sessionPath = [ "$HOME/bin" ];
    home.stateVersion = "24.11";
}
