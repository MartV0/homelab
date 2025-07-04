{ ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../modules/desktop_base.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos-vm"; # Define your hostname.
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true; # vm integration
  xdg.autostart.enable = true; # needed voor spice-vdagent to start I think?
}
