{ pkgs, ... }:
let
  target = "graphical-session.target";
in {
  # autostart seafile
  systemd.user.services.seafile = {
    path = [ pkgs.seafile-client pkgs.coreutils ];
    description = "Autostart seafile";
    wantedBy = [ target ];
    wants = [ target ];
    after = [ target ];
    serviceConfig = {
      Type = "exec";
      # Give network some time to connect
      ExecStartPre = "-${pkgs.coreutils}/bin/sleep 10";
      ExecStart = "-${pkgs.seafile-client}/bin/seafile-applet";
    };
  };
}

