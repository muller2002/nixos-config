{ config, lib, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.nodePackages.node-red
  ];
}
