{ ... }:
let url = "seafile.martijnv.com"; in {
  services.seafile = {
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
    gc.enable = true;
    ccnetSettings.General.SERVICE_URL = "https://${url}";
    user = "seafile";
    group = "seafile";
    workers = 2;
  };

  users.users.seafile = { 
    isSystemUser = true;
    group = "seafile";
  };
  users.groups.seafile = {};

  services.caddy.virtualHosts."${url}".extraConfig = ''
    reverse_proxy localhost:8083
  '';
}
