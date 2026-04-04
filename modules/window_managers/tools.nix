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
      imagemagick # for background selector
      pavucontrol
      xfce.thunar
      rofi
  ];
}
