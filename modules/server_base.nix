{ pkgs, hostname, username, agenix, system, ... }:
{
  imports =
    [ 
      ./../services/seafile/seafile.nix
      ./../services/caddy.nix
      ./../services/minecraft.nix
      ./../admin/ssh.nix
      ./../system/autoupdate.nix
      ./../system/datadisk.nix
      ./common_base.nix
      ./dev_base.nix
    ];


  users.users.martijn = {
    isNormalUser = true;
    extraGroups = [ "wheel" "seafile" ]; # Enable ‘sudo’ for the user.
    packages = [];
  };

  environment.systemPackages = with pkgs; [
    compose2nix
    docker-compose
  ];

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

