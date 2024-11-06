{ config, lib, pkgs, ... }:
{
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "martijn" ]; # TODO: this should use a shared variable or something with configuration.nix
    };
  };

  # TODO: also use var here
  users.users.martijn.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAeg9i8IMHJsL1CWjBdiH8cuYm7ssAwDwd8d/3soZftC martijn@localhost.localdomain"
  ];

  services.fail2ban.enable = true;
}
