{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-22.05";
    };
  };
  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    rec {
      packages.${system} = {
        proxmoxLxcTarball = nixosConfigurations.nixos-test.config.system.build.tarball;
      };

      nixosConfigurations.nixos-test = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ({ modulesPath, ... }: {
            imports = [
              (modulesPath + "/virtualisation/proxmox-lxc.nix")
            ];
            config = {
              nix.registry.nixpkgs = {
                from = {
                  id = "nixpkgs";
                  type = "indirect";
                };
                flake = nixpkgs;
              };
            };
          })
        ];
      };
    };
}
