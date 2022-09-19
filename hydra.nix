{ config, lib, pkgs, ... }:
{
  services.hydra = {
    enable = true;
    hydraURL = "https://hydra.marlena.app";
    notificationSender = "hydra@localhost";
    buildMachinesFiles = [ ];
    useSubstitutes = true;
  };
}
