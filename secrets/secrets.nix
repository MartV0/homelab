let
  laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAeg9i8IMHJsL1CWjBdiH8cuYm7ssAwDwd8d/3soZftC martijn@localhost.localdomain";
  system1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN+f7e90IN67BdWsRvUIRqtMvsJ9nomfnit/ZckgqRJP root@nixospi";
  nuc = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHv7MTHHKISLIPMHso3GLnVXlGgYGcMCG/ZVEB99UtCz martijn@nixos-nuc";
  keys = [ laptop system1 nuc ];
in
{
  "seafile-secrets.env".publicKeys = keys;
}
