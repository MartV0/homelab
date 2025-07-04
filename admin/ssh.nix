{ username, ... }:
{
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "${username}" ];
    };
  };

  users.users."${username}".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAeg9i8IMHJsL1CWjBdiH8cuYm7ssAwDwd8d/3soZftC martijn@localhost.localdomain"
  ];

  services.fail2ban.enable = true;
}
