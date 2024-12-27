{ pkgs, config, ... }:
let 
  url = "cloud.martijnv.com";
  nc_port = 8080;
in {
  age.secrets."nextcloud-passwd".file = ./../../secrets/nextcloud-passwd;

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud30;
    hostName = "localhost";
    config.adminpassFile = "/run/agenix/nextcloud-passwd";
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
    };
    # home = "/path/to/dir"
    extraAppsEnable = true;
    # TODO: mail delivery, redis, datadir/home, config.php, 
  };

  services.nginx.virtualHosts."localhost".listen = [ { addr = "127.0.0.1"; port = nc_port; } ];

  services.caddy.virtualHosts."${url}".extraConfig = ''
    reverse_proxy localhost:${nc_port}
  '';
}
