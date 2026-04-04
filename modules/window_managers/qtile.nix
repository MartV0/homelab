{ pkgs, ... }:
{
  imports = [ ./tools.nix ];

  services.xserver.windowManager.qtile.enable = true;
  services.xserver.enable = true;

  environment.systemPackages = with pkgs; [
      # qtile packages
      arandr
      flameshot
      picom
      xwallpaper
  ];
}
