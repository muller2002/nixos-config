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
        proxmoxLxcTarball = nixosConfigurations.nixos-minimal.config.system.build.tarball;
      };

      nixosConfigurations =
        let
          base = {
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

        in
        {
          nixos-minimal = nixpkgs.lib.nixosSystem
            base
          ;

          nixos-node-red = nixpkgs.lib.nixosSystem
            base // {
            modules = base.modules ++ [ ./node-red.nix ];
          }
          ;
        };
    };
}
