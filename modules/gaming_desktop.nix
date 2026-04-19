{ pkgs, username, ... }:
{
  imports = [ ./desktop_base.nix ];
  users.users."${username}" = {
    packages = with pkgs; [];
    extraGroups = ["gamemode"];
  };

  users.groups = {
    gamemode = {};
  };

  # makes some wine programs run better
  boot.kernelModules = [ "ntsync" ];

  environment.systemPackages = with pkgs; [ 
    gamemode
    gamescope
    mangohud
  ];
  # TODO: flake to make this declarative: https://github.com/different-name/steam-config-nix/blob/master/options.md
  # cs launch options
  # SDL_AUDIO_DRIVER=pulse gamescope -w 1728 -h 1080 -S stretch -f --force-grab-cursor -- %command% -vulkan

  # xbox wireless controller support
  hardware.xpadneo.enable = true;

  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraEnv = {
        MANGOHUD = "0";
        GAMEMODERUN = "1";
      };
    };
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
}

