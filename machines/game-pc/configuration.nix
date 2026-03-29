{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./../../modules/desktop_base.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
