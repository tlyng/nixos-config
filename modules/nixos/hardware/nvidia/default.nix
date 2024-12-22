{
    lib,
    config,
    pkgs,
    namespace,
    ...
}:
with lib;
with lib.${namespace}; let
    cfg = config.${namespace}.hardware.nvidia;
in {
    options.${namespace}.hardware.nvidia = with types; {
        enable = mkBoolOpt false "Whether or not to enable nvidia";
    };

    config = mkIf cfg.enable {
        services.xerver.videoDrivers = with pkgs; [ "nvidia" ];
        hardware.nvidia.modesetting.enable = true;
    };
}
