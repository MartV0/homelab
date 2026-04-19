{ pkgs, pkgs-unstable, ... }:
{
  imports = [ ./tools.nix ];

  programs.niri.enable = true;

  security.polkit.enable = true;

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "niri.service" ];
    wants = [ "niri.service" ];
    after = [ "niri.service" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  environment.systemPackages = with pkgs; [
    polkit_gnome
    phinger-cursors

    # wayland wm
    mako
    waybar
    xwayland-satellite
    hyprlock
  ] ++ [ pkgs-unstable.awww ];

  # needed by gtk4 apps for compose keys
  i18n.inputMethod = {
    enable = true;
    type = "ibus";
  };
}
