{ staticSite, config, ... }:
{
  services.caddy = {
    enable = true;

    virtualHosts."martijnv.com".extraConfig = ''
      header   Cache-Control no-cache
      header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload"

      handle_path /comments/* {
        reverse_proxy localhost:8123 {
          header_up X-Script-Name /comments
          header_up X-Forwarded-Proto {scheme}
          header_up X-Forwarded-For {remote}
          header_up Host {host}
        }
      }

      handle_path /freshrss* {
        root * ${config.services.freshrss.package}/p
        php_fastcgi unix/${config.services.phpfpm.pools.freshrss.socket} {
            env FRESHRSS_DATA_PATH ${config.services.freshrss.dataDir}
        }
        file_server
      }

      handle {
        root * ${staticSite.website.src}
        file_server
      }
    '';
  };

  environment.etc."fail2ban/filter.d/caddy-status.conf".text = ''
    [Definition]
    failregex = ^.*"remote_ip":"<HOST>".*"status":(401|403|404|408|429|500|501).*$;
    ignoreregex =
    datepattern = LongEpoch
  '';

  services.fail2ban.jails = {
    caddy-status = {
      settings = {
        enabled = true;
        filter = "caddy-status";
        logpath = "${config.services.caddy.logDir}/access-*.log";
      };
    };
  };
}
