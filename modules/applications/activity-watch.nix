{ pkgs, ... }:
let
  target = "graphical-session.target";
in {
  environment.systemPackages = with pkgs; [ 
    activitywatch
    aw-watcher-window-wayland
  ];

  # autostart activity watch
  systemd.user.services.activitywatch = {
    path = [ pkgs.activitywatch pkgs.coreutils ];
    description = "Autostart activity watch";
    wantedBy = [ target ];
    wants = [ target ];
    after = [ target ];
    serviceConfig = {
      Type = "exec";
      # give systray some time to start
      ExecStartPre = "-${pkgs.coreutils}/bin/sleep 10";
      ExecStart = "-${pkgs.activitywatch}/bin/aw-qt";
    };
  };
}

