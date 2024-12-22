{
    lib,
    config,
    pkgs,
    namespace,
    ...
}:
with lib;
with lib.${namespace}; let
    cfg = config.${namespace}.apps.terminals;
in {
    options.${namespace}.apps.terminals = with types; {
        enable = mkBoolOpt false "Whether or not to enable default terminals";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            alacritty
            kitty
        ];
    };
}
