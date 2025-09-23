{ pkgs, hostname, username, agenix, system, inputs, outputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs username;};
    useGlobalPkgs = true;
    useUserPackages = true;
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
    home-manager
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
      pull.rebase = false;
      user.email = "martijnvoordouw@gmail.com";
      user.name = "MartV0";
    };
  };

  system.stateVersion = "24.11";
}
