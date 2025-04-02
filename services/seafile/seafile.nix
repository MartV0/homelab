{ pkgs, ... }:
let url = "seafile.martijnv.com"; in {
  age.secrets."seafile-secrets.env".file = ./../../secrets/seafile-secrets.env;

  virtualisation.docker.enable = true;

  services.caddy.virtualHosts."${url}".extraConfig = ''
    reverse_proxy localhost:8083
  '';

  systemd.services.seafile = let current_dir = ./.; in {
    path = with pkgs; [
      docker-compose
      docker
    ];
    name = "seafile.service";
    wants = [ "docker.service" ];
    wantedBy = ["multi-user.target"]; # Start during boot
    after = [ "docker.service" ];
    script = ''
      docker compose -f ${current_dir}/seafile-server.yml --env-file ${current_dir}/seafile.env --env-file /run/agenix/seafile-secrets.env up --pull always --quiet-pull
    '';
    preStop = ''
      docker compose -f ${current_dir}/seafile-server.yml --env-file ${current_dir}/seafile.env --env-file /run/agenix/seafile-secrets.env down
    '';
  };
}
