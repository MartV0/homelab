{ ... }:
{
  imports =
    [ 
      ./hardware-configuration.nix
      ./../../modules/desktop_base.nix
    ];

  desktop.gaming.enable = false;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.graphics.enable = true;
  # GPU driver stuff (not sure if amdgpu is needed for integrated graphics?)
  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];
  hardware.nvidia = {
    open = true;
    powerManagement.enable = true;
    prime = {
      nvidiaBusId = "PCI:1@0:0:0";
      amdgpuBusId = "PCI:5@0:0:0"; # If you have an AMD iGPU
      offload.enable = true;
      # sync.enable = true;
    };
  };
}
