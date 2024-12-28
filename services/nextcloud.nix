{ pkgs, config, ... }:
let
  url = "cloud.martijnv.com";
  nc_port = 8080;
in {
  age.secrets."nextcloud-passwd" = {
    file = ./../secrets/nextcloud-passwd;
    mode = "770";
    owner = "nextcloud";
    group = "nextcloud";
  };

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud30;
    hostName = "localhost";
    config = {
      adminuser = "admin";
      adminpassFile = config.age.secrets."nextcloud-passwd".path;
      dbtype = "pgsql";
    };
    database.createLocally = true;
    settings = {
      trusted_domains = [ url ];
      overwriteprotocol = "https";
      overwritehost = url;
    };
    # extraApps = {
    #   inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
    # };
    # extraAppsEnable = true;
    # home = "/path/to/dir"
    # TODO: mail delivery, redis, datadir/home, config.php,
  };


  services.nginx.virtualHosts."localhost".listen = [ { addr = "127.0.0.1"; port = nc_port; } ];

  services.caddy.virtualHosts."${url}".extraConfig = ''
    reverse_proxy localhost:${toString nc_port}
  '';
}
