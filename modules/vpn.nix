{ pkgs-unstable, ... }:
{
  environment.systemPackages = with pkgs-unstable; [ 
      mullvad
      mullvad-vpn
      mullvad-browser
  ];

  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs-unstable.mullvad-vpn;

  networking.wireguard.enable = true;

  networking.firewall = {
    checkReversePath = "loose";
    allowedUDPPorts = [ 51820 ];
  };

  services.resolved.enable = true;
}

