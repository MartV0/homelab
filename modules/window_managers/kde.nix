{ pkgs, lib, config, ... }:
{
  options.wm.kde.enable = lib.mkOption {
    default = true;
    type = lib.types.bool;
  };

  config = lib.mkIf config.wm.kde.enable {
    services.desktopManager.plasma6.enable = true;

    environment.systemPackages = with pkgs; [
        kdePackages.kate
        aspell
        aspellDicts.en
        aspellDicts.nl
        aspellDicts.en-computers
        aspellDicts.en-science
    ];
  };
}
