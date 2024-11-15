{ config, lib, pkgs, staticSite, ... }:
{
  services.caddy = {
    enable = true;
    virtualHosts."martijnv.com".extraConfig = ''
      root * ${staticSite.website.src}
      file_server
    '';
  };
}
