
{ pkgs, hostname, username, agenix, system, ... }:

{
  environment.systemPackages = with pkgs; [
    sqlite
    jq
  ];

  programs.tmux = {
    enable = true;
    clock24 = true;
  };
}
