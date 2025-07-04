{ config, lib, pkgs, username, ... }:

let
  dotfiles = config.lib.file.mkOutOfStoreSymlink "/home/martijn/dotfiles";
in
{
  xdg.configFile = {
    alacritty.source = "${dotfiles}/.config/alacritty";
    doom.source = "${dotfiles}/.config/doom";
    fish.source = "${dotfiles}/.config/fish";
    flameshot.source = "${dotfiles}/.config/flameshot";
    nvim.source = "${dotfiles}/.config/nvim";
    picom.source = "${dotfiles}/.config/picom";
    qtile.source = "${dotfiles}/.config/qtile";
    ranger.source = "${dotfiles}/.config/ranger";
    rofi.source = "${dotfiles}/.config/rofi";
    zathura.source = "${dotfiles}/.config/zathura";
  };

  # home.file = {
  #   ".Xresources" = "${dotfiles}/.Xresources";
  #   ".gitconfig" = "${dotfiles}/.gitconfig";
  #   ".latexmkrc" = "${dotfiles}/.latexmkrc";
  #   autostart.sh = "${dotfiles}/autostart.sh";
  #   drive.sh = "${dotfiles}/drive.sh";
  # };
}
