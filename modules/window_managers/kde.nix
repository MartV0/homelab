{ pkgs, ... }:
{
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs; [
      kdePackages.kate
      aspell
      aspellDicts.en
      aspellDicts.nl
      aspellDicts.en-computers
      aspellDicts.en-science
  ];
}
