{ ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./../../modules/desktop_base.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # GPU driver stuff (not sure if amdgpu is needed for integrated graphics?)
  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];
  hardware.graphics.enable = true;
  hardware.nvidia.open = true;
  # TODO: prime (dual gpu) setup?
}
