{ config, username, pkgs, ... }:

let
  dotfiles = config.lib.file.mkOutOfStoreSymlink "/home/${username}/dotfiles";
in
{
  xdg.configFile = {
    alacritty.source = "${dotfiles}/.config/alacritty";
    doom.source = "${dotfiles}/.config/doom";
    fish.source = "${dotfiles}/.config/fish";
    flameshot.source = "${dotfiles}/.config/flameshot";
    hypr.source = "${dotfiles}/.config/hypr";
    mako.source = "${dotfiles}/.config/mako";
    niri.source = "${dotfiles}/.config/niri";
    nvim.source = "${dotfiles}/.config/nvim";
    picom.source = "${dotfiles}/.config/picom";
    qtile.source = "${dotfiles}/.config/qtile";
    ranger.source = "${dotfiles}/.config/ranger";
    rofi.source = "${dotfiles}/.config/rofi";
    waybar.source = "${dotfiles}/.config/waybar";
    zathura.source = "${dotfiles}/.config/zathura";
    keepassxc.source = "${dotfiles}/.config/keepassxc";
  };

  home.file = {
    ".Xresources".source = "${dotfiles}/.Xresources";
    ".gitconfig".source = "${dotfiles}/.gitconfig";
    ".gdbinit".source = "${dotfiles}/.gdbinit";
    ".ssh".source = "${dotfiles}/.ssh";
    ".latexmkrc".source = "${dotfiles}/.latexmkrc";
    "autostart.sh".source = "${dotfiles}/autostart.sh";
    "drive.sh".source = "${dotfiles}/drive.sh";
    ".local/share/icons/phinger-cursors".source = "${pkgs.phinger-cursors}/share/icons/phinger-cursors";
  };
}
