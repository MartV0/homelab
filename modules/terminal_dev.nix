{ pkgs, username, ... }:

{
  environment.systemPackages = with pkgs; [
    sqlite
    jq

    # terminal/shell stuff
    btop
    cowsay
    eza
    fish
    fortune-kind
    fzf
    gdb
    mlocate
    lolcat
    ranger
    inetutils
    zoxide
    zsh

    # dev stuff
    dotnet-sdk # maybe install more version
    neovim
    # nvim dependecies
    ripgrep
    fd
    gcc
    deno # Used by peek.nvim
    # nodePackages.npm
    # nodejs
    python315
    cargo
    rustc

    # tools/utilities
    btrfs-progs
    cron
    rar
    rclone
    stow
    unrar
    unzip # also for mason.nvim

    ntfs3g # ntfs support

    # language servers:
    csharp-ls
    haskell-language-server
    lua-language-server
    nil
    pyright
    rust-analyzer
    typescript-language-server
    vue-language-server

    # formatters/linters
    black
    prettier
    python313Packages.flake8
    eslint
    rustfmt
  ];

  programs.tmux = {
    enable = true;
    clock24 = true;
  };

  users.users."${username}" = {
    extraGroups = [ "mlocate" ];
  };

  users.groups = {
    mlocate = {};
  };
}
