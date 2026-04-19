{ pkgs, username, ... }:
{
  imports =
    [ 
      ./../services/seafile/seafile.nix
      ./../services/caddy.nix
      ./../services/comments.nix
      # ./../services/minecraft.nix
      ./../admin/ssh.nix
      ./../system/autoupdate.nix
      ./../system/datadisk.nix
      ./common_base.nix
      ./terminal_dev.nix
    ];


  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = [];
  };

  environment.systemPackages = with pkgs; [];

  users.groups = {
    seafile = {};
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
    25565 # minecraft
  ];

  programs.ssh.extraConfig = ''
    IdentityFile /home/${username}/.ssh/id_ed25519
  '';

  # networking.firewall.allowedUDPPorts = [ ... ];

  system.stateVersion = "24.11";
}

