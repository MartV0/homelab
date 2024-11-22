{ config, lib, pkgs, staticSite, ... }:
{
  services.caddy = {
    enable = true;
    virtualHosts."martijnv.com".extraConfig = ''
      header   Cache-Control no-cache
      root * ${staticSite.website.src}
      file_server
    '';
  };
}
