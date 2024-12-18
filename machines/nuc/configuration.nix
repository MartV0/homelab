{ ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./../../modules/server_base.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
}

