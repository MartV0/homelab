{ pkgs, hostname, username, agenix, system, ... }:

{
  imports =
    [ 
      ./../services/seafile/seafile.nix
      ./../services/caddy.nix
      ./../admin/ssh.nix
      ./../system/autoupdate.nix
      ./../system/datadisk.nix
    ];


  nixpkgs.config.allowUnfree = true;

  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Amsterdam";

  users.users.martijn = {
    isNormalUser = true;
    extraGroups = [ "wheel" "seafile" ]; # Enable ‘sudo’ for the user.
    packages = [];
    uid = 1001;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    killall
    git
    fastfetch
    htop
    age
    sqlite
    jq
    just
    agenix.packages.${system}.default
    compose2nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.vim.defaultEditor = true;
  programs.vim.enable = true;

  programs.git = { 
    enable = true;
    config = {
      init = {
        defaultBranch = "main";
      };
      pull.rebase = true;
      user.email = "martijnvoordouw@gmail.com";
      user.name = "MartV0";
    };
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  programs.ssh.extraConfig = ''
    IdentityFile /home/${username}/.ssh/id_ed25519
  '';

  # networking.firewall.allowedUDPPorts = [ ... ];

  system.stateVersion = "24.11";
}

