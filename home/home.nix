{ username, ... }:

{
  imports = [
    ./neovim.nix
    ./symlinks.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "24.05";

  home.packages = [];

  xdg.desktopEntries.tidal-hifi = {
    name = "TIDAL Hi-Fi";
    # --no-sandbox is needed, otherwise white screen
    exec = "tidal-hifi --no-sandbox";
    icon = "tidal-hifi";
    terminal = false;
  };

  home.file = {
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = false;
}
