{ config, lib, pkgs, ... }:
{
  services.seafile = {
    enable = true;
    adminEmail = "martijnvoordouw@gmail.com";
    # dataDir = "/path";
    # group = "";
    initialAdminPassword = "wachtwoord"; #TODO
    # seafileSettings = "https://manual.seafile.com/config/seafile-conf/";
    seafileSettings = {
      fileserver = {
        port = 8082;
        host = "ipv4:127:0:0.1";
      };
      seahubAdress = "0.0.0.0:8083";
    };
    # user = "seafile";
    # workers = 4;
  };
}
