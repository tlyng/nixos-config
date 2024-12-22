{
    lib,
    config,
    pkgs,
    namespace,
    ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.desktop.addons.sddm;
in {
  options.${namespace}.desktop.addons.sddm = with types; {
    enable = mkBoolOpt false "Whether or not to enable the SDDM display manager";
  };

  config = mkIf cfg.enable {
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    services.displayManager.sddm.theme = "breeze";
  };
    
}
