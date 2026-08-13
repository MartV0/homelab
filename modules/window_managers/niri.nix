{ pkgs, pkgs-unstable, ... }:
{
  imports = [ ./tools.nix ];

  programs.niri = {
    enable = true;
  };

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
    wdisplays
    swaynotificationcenter
    waybar
    xwayland-satellite
    hyprlock
    awww
    swayidle
  ];

  # We define this as a custom service so we can add our own packages
  systemd.user.services.hypridle = {
    enable = true;
    after = [ "niri.service" ];
    wantedBy = [ "niri.service" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs-unstable.hypridle}/bin/hypridle";
    };
    path = 
      with pkgs; [ niri hyprlock systemd coreutils brightnessctl procps bash ]
      # unstable needed for condition_cmd
      ++ [ pkgs-unstable.hypridle ];
  };

  # Manual systemd config so the unit isn't started in kde for example
  systemd.user.services.swaync = {
    enable = true;
    after = [ "niri.service" ];
    wantedBy = [ "niri.service" ];
    serviceConfig = {
      Type="dbus";
      BusName="org.freedesktop.Notifications";
      ExecStart = "${pkgs.swaynotificationcenter}/bin/swaync";
      ExecReload = "${pkgs.swaynotificationcenter}/bin/swaync-client --reload-config ; ${pkgs.swaynotificationcenter}/bin/swaync-client --reload-css";
    };
  };

  # TODO:needed by gtk4 apps for compose keys
  # i18n.inputMethod = {
  #   enable = true;
  #   type = "ibus";
  # };
}
