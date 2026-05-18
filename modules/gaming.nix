{ pkgs-unstable, username, lib, config, ... }:
{
  imports = [ ];

  options.desktop.gaming.enable = lib.mkOption {
    default = false;
    type = lib.types.bool;
  };

  config = lib.mkIf config.desktop.gaming.enable {
    users.users."${username}" = {
      extraGroups = [ "gamemode" ];
    };

    users.groups = {
      gamemode = { };
    };

    # makes some wine programs run better
    boot.kernelModules = [ "ntsync" ];

    environment.systemPackages = with pkgs-unstable; [
      gamemode
      gamescope
      mangohud
      protonup-ng
      # needed for protontricks
      freetype
    ];

    # TODO: flake to make this declarative: https://github.com/different-name/steam-config-nix/blob/master/options.md
    # cs launch options
    # LD_PRELOAD="" SDL_AUDIO_DRIVER=pulse gamescope -w 1728 -h 1080 -S stretch -f --force-grab-cursor -- %command% -vulkan

    # xbox wireless controller support
    hardware.xpadneo.enable = true;

    programs.steam = {
      enable = true;
      package = pkgs-unstable.steam.override {
        extraEnv = {
          MANGOHUD = "0";
          GAMEMODERUN = "1";
        };
      };
      protontricks = {
        enable = true;
        package = pkgs-unstable.protontricks;
      };
      extraCompatPackages = [ ];
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    # Assetto corsa install instructions, taken from: https://github.com/JManch/nixos/blob/6be5fa423923d66648e5bab55a6c4fe021d1c0d8/modules/nixos/programs/gaming/steam.nix#L31
    # - protonup -t GE-Proton9-4
    # - in steam compatibility setting force proton-ge 9.4
    # - Run assetto corsa once then close
    # - Download content manager, and place in assetto corsa folder
    # - cd /home/martijn/.local/share/Steam/steamapps/common/assettocorsa/ && ln Content\ Manager.exe AssettoCorsa.exe
    # - go into compatdata: /home/martijn/.local/share/Steam/steamapps/compatdata/244210/pfx/drive_c/Program Files (x86)/Steam/config/
    # - soft link /home/martijn/.steam/root/config/loginusers.vdf to above folder
    # - Launch "protontricks 244210 winecfg" in protontricks
    # - add dwrite to libraries
    # - enable hidden files in wine file browser
    # - Inside the winecfg libraries tab add a new override for library 'dwrite'
    # - Run `protontricks 244210 corefonts` (can also be installed through UI but the pop-ups are annoying)
    # - Download content manager and place in steamapps/common/assettocorsa folder
    # - Rename content manager executable to 'Content Manager Safe.exe'
    # - Symlink loginusers.vdf to the prefix with `ln -s ~/.steam/root/config/loginusers.vdf ~/.local/share/Steam/steamapps/compatdata/244210/pfx/drive_c/Program\ Files\ \(x86\)/Steam/config/loginusers.vdf`
    # - Launch content manager with `protontricks-launch --appid 244210 ./Content\ Manager\ Safe.exe`
    # - Set assetto corsa root directory to z:/home/joshua/../steamapps/common/assettocorsa (using the z: drive is important)
    # - Inside Settings/Content Manager/Appearance settings disable window transparency and hardware acceleration for UI
    # - Inside Settings/Content Manager/Drive click the 'Switch game start to Steam' button
    #   it will show a warning about replacing the AssettoCorsa.exe, proceed
    # - Close the protontricks-launch instance of content manager and launch assetto corsa from Steam
    # - When installing custom shaders patch install one of the latest versions (old stable versions don't work)
  };
}
