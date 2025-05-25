{ config, lib, pkgs-unstable, staticSite, ... }:
{
  services.minecraft-server = {
    enable = true;
    eula = true;
    package = pkgs-unstable.papermcServers.papermc-1_21_4;
    declarative = true;
    # whitelist = {
    #     # This is a mapping from Minecraft usernames to UUIDs. You can use https://mcuuid.net/ to get a Minecraft UUID for a username
    #     username1 = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx";
    #     username2 = "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy";
    # };
    serverProperties = {
        server-port = 25565 ;
    #     difficulty = 3;
    #     gamemode = 1;
    #     max-players = 5;
    #     white-list = true;
        motd = "8=====D~~~~~   <--- dat is een raket";
        level-seed="991073392998374744";
        allow-cheats = true;
        enable-rcon=true;
        "rcon.password"="kaas";
    };
  };

  environment.systemPackages = [ pkgs-unstable.mcrcon ];
}
