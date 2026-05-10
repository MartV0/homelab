{ username, lib, config, ... }:
{
  imports = [
    ./neovim.nix
    ./symlinks.nix
    ./desktop.nix
  ];

  config = {
    home.username = username;
    home.homeDirectory = "/home/${username}";

    home.stateVersion = "24.05";

    home.packages = [];

    home.file = {
    };

    home.sessionVariables = {
      # EDITOR = "emacs";
    };

    programs.home-manager.enable = false;
  };

  options = {
    isDesktop = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };
}
