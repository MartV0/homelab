{ pkgs, username, ... }:
{
  imports = [ ./desktop_base.nix ];
  users.users."${username}" = {
    packages = with pkgs; [];
    extraGroups = ["gamemode"];
  };

  environment.systemPackages = with pkgs; [ gamemode ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
}

