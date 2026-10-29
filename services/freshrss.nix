{ config, pkgs, lib, ... }:
let
  user = "freshrss";
  group = "freshrss";
  package = pkgs.freshrss;
in
{
  age.secrets = lib.mkIf config.services.freshrss.enable {
    "freshrss-passwd" = {
      file = ./../secrets/freshrss-passwd;
      mode = "440";
      owner = user;
      group = group;
    };
  };

  users = lib.mkIf config.services.freshrss.enable {
    groups = {
      "${group}" = {};
    };
    users."${user}" = {
      extraGroups = [ group ];
    };
  };

  services.freshrss = {
    enable = true;
    package = package;
    defaultUser = "martijn";
    baseUrl = "http://192.168.2.12:8080/";
    language = "nl";
    passwordFile = config.age.secrets."freshrss-passwd".path;
    user = user;
    webserver = "caddy";
    virtualHost = "freshrss";
  };
}
