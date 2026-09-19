{ ... }:
{
  imports =
    [ 
      ./hardware-configuration.nix
      ./../../modules/desktop_base.nix
    ];

  desktop.gaming.enable = false;
  plymouth-screen.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.displayManager.defaultSession = "niri";

  hardware.graphics.enable = true;
  # GPU driver stuff (not sure if amdgpu is needed for integrated graphics?)
  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];
  hardware.nvidia = {
    open = true;
    # nvidia support for suspend and stuff
    powerManagement.enable = true;
    # Unrelated to the above power management, allows gpu offload
    powerManagement.finegrained = true;
    prime = {
      nvidiaBusId = "PCI:1@0:0:0";
      amdgpuBusId = "PCI:5@0:0:0";
      # Only use gpu for specific applications
      offload.enable = true;
      # sync.enable = true;
    };
  };
}
