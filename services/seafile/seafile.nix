{ config, lib, pkgs, ... }:
let url = "seafile.martijnv.com"; in {
  imports = [
    # ./seafile-server-compose.nix
  ]; 

  age.secrets."seafile-secrets.env".file = ./../../secrets/seafile-secrets.env;

  services.caddy.virtualHosts."${url}".extraConfig = ''
    reverse_proxy localhost:8083
  '';
}
