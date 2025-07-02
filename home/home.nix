{ config, pkgs, username, ... }:

{
  imports = [
    ./neovim.nix
    ./symlinks.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "24.05";

  home.packages = [
  ];

  home.file = {
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = false;
}
