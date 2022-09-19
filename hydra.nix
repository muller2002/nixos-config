{ config, lib, pkgs, ... }:
{
  services.hydra = {
    enable = true;
    hydraURL = "https://hydra.marlena.app:3000";
    notificationSender = "hydra@localhost";
    buildMachinesFiles = [ ];
    useSubstitutes = true;
  };
}
