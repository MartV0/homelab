{ ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./../../modules/desktop_base.nix
    ];

  desktop.gaming.enable = true;
  desktop.uni.enable = false;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Not sure if this is actually needed
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
