{ pkgs, hostname, username, agenix, system, inputs, outputs, pkgs-unstable, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs username pkgs-unstable;};
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    users = {
      ${username} = {
        imports = [
          ./../home/home.nix
        ];
      };
    };
  };

  nixpkgs.config.allowUnfree = true;

  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Amsterdam";

  environment.systemPackages = with pkgs; [
    vim
    wget
    killall
    git
    fastfetch
    htop
    age
    just
    agenix.packages.${system}.default
    tree
    ncdu
    home-manager
    isd
  ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      download-buffer-size = 500000000;
    };
  };

  programs.vim.defaultEditor = true;
  programs.vim.enable = true;

  programs.git = { 
    enable = true;
    config = {
      init = {
        defaultBranch = "main";
      };
      pull.rebase = false;
      user.email = "martijnvoordouw@gmail.com";
      user.name = "MartV0";
      commit.gpgsign = false;
    };
  };

  system.stateVersion = "24.11";
}
