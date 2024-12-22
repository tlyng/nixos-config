{
    lib,
    config,
    pkgs,
    namespace,
    ...
}:
with lib;
with lib.${namespace};
{
    imports = [
        ./disko-config.nix
    ];

    # Enable Bootloader (EFI or BIOS)
    homelab.system.boot.efi.enable = true;
    homelab.hardware.networking.enable = true;
    homelab.hardware.nvidia.enable = true;

    # Enable Desktop environment
    homelab.suites.desktop.enable = true;

    environment.systemPackages = with pkgs; [
        lolcat
        cowsay
        zsh
    ];

    programs.zsh.enable = true;

    homelab.user = {
       name = "torkel"; 
       extraGroups = [ "wheel" ];
    };
    system.stateVersion = "24.11";
}
