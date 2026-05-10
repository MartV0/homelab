{ config, ... }:
let
  user = "freshrss";
  group = "freshrss";
in
{
  age.secrets."freshrss-passwd" = {
    file = ./../secrets/freshrss-passwd;
    mode = "440";
    owner = user;
    group = group;
  };

  users.groups = {
    "${group}" = {};
  };

  users.users."${user}" = {
    extraGroups = [ group ];
  };

  # services.caddy.virtualHosts.freshrss = {
  # };

  services.freshrss = {
    enable = true;
    defaultUser = "martijn";
    baseUrl = "https://martijnv.com/freshrss";
    language = "nl";
    passwordFile = config.age.secrets."freshrss-passwd".path;
    user = user;
    webserver = "caddy";
  };
}
