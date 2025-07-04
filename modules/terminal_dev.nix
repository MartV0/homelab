{ pkgs, ... }:

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
    lolcat
    ranger
    zoxide
    zsh

    # dev stuff
    dotnet-sdk # maybe install more version
    emacs
    neovim
    # nvim dependecies
    ripgrep
    fd
    gcc
    nodePackages.npm
    nodejs
    python3Full
    python311Packages.pip

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
    nodePackages.prettier
    python313Packages.flake8
    eslint
  ];

  programs.tmux = {
    enable = true;
    clock24 = true;
  };
}
