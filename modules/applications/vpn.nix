{ pkgs-unstable, ... }:
{
  environment.systemPackages = with pkgs-unstable; [ 
    proton-vpn
    proton-vpn-cli
  ];

  networking.firewall.checkReversePath = "loose";
}

