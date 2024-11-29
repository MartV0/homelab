{ config, lib, pkgs, ... }:
{
  services.seafile = {
    enable = true;
    adminEmail = "martijnvoordouw@gmail.com";
    seahubAddress = "0.0.0.0:8083";
    # dataDir = "/path";
    # group = "";
    initialAdminPassword = "wachtwoord"; #TODO
    # seafileSettings = "https://manual.seafile.com/config/seafile-conf/";
    seafileSettings = {
      fileserver = {
        port = 8082;
        host = "ipv4:0.0.0.0";
      };
    };
    gc.enable = true; # TODO garbage collection?
    ccnetSettings.General.SERVICE_URL = "http://0.0.0.0:8083/"
    # user = "seafile";
    # workers = 4;
  };
}
