{ config, lib, pkgs, ... }:
let url = "seafile.martijnv.com"; in {
  services.seafile = {
    # enable = false;
    enable = true;
    adminEmail = "martijnvoordouw@gmail.com";
    seahubAddress = "127.0.0.1:8083";
    # setting dataDir seems to be broken
    # dataDir = "/datadisk/seafile/data";
    initialAdminPassword = "wachtwoord"; #TODO
    # seafileSettings = "https://manual.seafile.com/config/seafile-conf/";
    seafileSettings = {
      fileserver = {
        port = 8082;
        host = "ipv4:127.0.0.1";
      };
    };
    gc.enable = true; # TODO garbage collection?
    ccnetSettings.General.SERVICE_URL = "https://${url}";
    user = "seafile";
    group = "seafile";
    # workers = 4;
  };

  services.caddy.virtualHosts."${url}".extraConfig = ''
    reverse_proxy localhost:8083
  '';

  users.users.seafile = { 
    isSystemUser = true;
    group = "seafile";
  };
  users.groups.seafile = {};

  # create seafile directory if it doesn't exist yet (not temporary like the option name suggests)
  systemd.tmpfiles.rules = [
    "d /datadisk/seafile 0777 seafile seafile" 
    "d /datadisk/seafile/data 0777 seafile seafile" 
    # hacky
    # "L+ /var/lib/seafile/data - - - - /datadisk/seafile/data" 
  ];
 
  systemd.services.seaf-server.after = [ "datadisk.mount" ];
  systemd.services.seaf-server.requires = [ "datadisk.mount" ];
}
