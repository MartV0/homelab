{ ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./../../modules/gaming_desktop.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Not sure if this is actually needed
  services.xserver.videoDrivers = [ "amdgpu" ];
}
