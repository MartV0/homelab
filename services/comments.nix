{ config, ... }:
{
  age.secrets.isso-secrets-env.file = ./../secrets/isso-secrets.env;

  services.isso = {
    enable = true;
    settings = {
      general = {
        dbpath = "/var/lib/isso/comments.db";
        host = ''
          http://martijnv.com
          https://martijnv.com
        '';
      };
      server = {
        listen = "http://localhost:8123";
      };
      admin = {
        enabled = true;
        password = "\${ADMIN_PASSWORD}";
      };
      rss = {
        limit = 50;
        base = "https://martijnv.com/";
      };
    };
    secretFile = config.age.secrets.isso-secrets-env.path;
  };
}
