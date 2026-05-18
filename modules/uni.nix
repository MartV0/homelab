{ pkgs, lib, config, ... }:
{
  imports = [ ];

  options.desktop.uni.enable = lib.mkOption {
    default = true;
    type = lib.types.bool;
  };

  config = lib.mkIf config.desktop.uni.enable {
    environment.systemPackages = with pkgs; [
      zotero
      jetbrains.idea
      teams-for-linux
      pandoc
      texliveFull
      python313Packages.pygments # needed for minted latex package
      texlivePackages.texments
    ];
  };
}
