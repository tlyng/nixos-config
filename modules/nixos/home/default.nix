{
    lib,
    config,
    pkgs,
    namespace,
    options,
    inputs,
    ...
}:
with lib;
with lib.${namespace}; let
    cfg = config.${namespace}.home;
in {
    imports = with inputs; [
        home-manager.nixosModules.home-manager
    ];
    options.${namespace}.home = with types; {
        file = mkOpt attrs { } (
            mdDoc "A set of files to be managed by home-manager's `home.file`."
        );
        configFile = mkOpt attrs { } (
            mdDoc "A set of files to be managed by home-manager's `xdg.configFile`."
        );
        extraOptions = mkOpt attrs { } (
            mdDoc "A set of extra options to be passed to home-manager."
        );
    };

    config = {
        homelab.home.extraOptions = {
            home.stateVersion = config.system.stateVersion or "24.11";
            home.file = mkAliasDefinitions options.${namespace}.home.file;
            xdg.enable = true;
            xdg.configFile = mkAliasDefinitions options.${namespace}.home.configFile;
        };

        # homelab.user.torkel.home.config =
        #     config.${namespace}.home.extraOptions;

        home-manager = {
            useUserPackages = true;
            useGlobalPkgs = true;

            users.${config.${namespace}.user.name} =
                mkAliasDefinitions options.${namespace}.home.extraOptions;
        };
    };
}
