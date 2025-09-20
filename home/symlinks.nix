{ config, username, ... }:

let
  dotfiles = config.lib.file.mkOutOfStoreSymlink "/home/${username}/dotfiles";
in
{
  xdg.configFile = {
    alacritty.source = "${dotfiles}/.config/alacritty";
    doom.source = "${dotfiles}/.config/doom";
    fish.source = "${dotfiles}/.config/fish";
    flameshot.source = "${dotfiles}/.config/flameshot";
    niri.source = "${dotfiles}/.config/niri";
    nvim.source = "${dotfiles}/.config/nvim";
    picom.source = "${dotfiles}/.config/picom";
    qtile.source = "${dotfiles}/.config/qtile";
    ranger.source = "${dotfiles}/.config/ranger";
    rofi.source = "${dotfiles}/.config/rofi";
    waybar.source = "${dotfiles}/.config/waybar";
    zathura.source = "${dotfiles}/.config/zathura";
  };

  home.file = {
    ".Xresources".source = "${dotfiles}/.Xresources";
    ".gitconfig".source = "${dotfiles}/.gitconfig";
    ".latexmkrc".source = "${dotfiles}/.latexmkrc";
    "autostart.sh".source = "${dotfiles}/autostart.sh";
    "drive.sh".source = "${dotfiles}/drive.sh";
  };
}
