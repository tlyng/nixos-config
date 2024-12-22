{
    description = "test configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
        home-manager = {
            url = "github:nix-community/home-manager/release-24.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        disko = {
            url = "github:nix-community/disko";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        snowfall-lib = {
            url = "github:snowfallorg/lib";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nixos-generators = {
            url = "github:nix-community/nixos-generators";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs =
        inputs:
        let
          lib = inputs.snowfall-lib.mkLib {
              inherit inputs;
              src = ./.;

              snowfall = {
                  meta = {
                      name = "test configuration";
                      title = "test config";
                  };

                  namespace = "homelab";
              };
          };
        in 
        lib.mkFlake {
            inherit inputs;
            src = ./.;
            
            channels-config = {
                allowUnfree = true;
            };

            overlays = with inputs; [];

            systems.modules.nixos = with inputs; [
                home-manager.nixosModules.home-manager
            ];

            systems.hosts.test.modules = with inputs; [
                disko.nixosModules.disko
            ];
        };
}
