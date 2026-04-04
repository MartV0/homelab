{ pkgs, ... }:
{
  # Packages that are replacements for stuff that is normally included in DE
  environment.systemPackages = with pkgs; [
      blueman
      brightnessctl
      font-manager
      lxappearance
      networkmanager
      networkmanagerapplet
      pavucontrol
      xfce.thunar
      rofi
  ];
}
