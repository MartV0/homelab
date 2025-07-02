{ config, lib, pkgs, username, ... }:

let
  dotfiles = config.lib.file.mkOutOfStoreSymlink "/home/martijn/dotfiles";
in
{
  xdg.configFile = {
    nvim.source = "${dotfiles}/.config/nvim";
  };
}
