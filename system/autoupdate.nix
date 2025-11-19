{ pkgs, username, flakePath, ... }:
{
  systemd.services = {
    flake-update = {
      preStart = "${pkgs.host}/bin/host example.com";  # Check network connectivity
      unitConfig = {
        Description = "Update flake inputs";
        StartLimitIntervalSec = 300;
        StartLimitBurst = 5;
      };
      serviceConfig = {
        ExecStart = "${pkgs.nix}/bin/nix flake update --commit-lock-file --flake ${flakePath}";
        Restart = "on-failure";
        RestartSec = "30";
        Type = "oneshot"; # Ensure that it finishes before starting nixos-upgrade
        User = "${username}";
      };
      before = ["nixos-upgrade.service"];
      requiredBy = ["nixos-upgrade.service"];
      path = [pkgs.nix pkgs.git pkgs.host];
    };
  };

  system.autoUpgrade = {
    enable = true;
    dates = "3:00";
    flake = flakePath;
    flags = [ "--impure" ];
    allowReboot = true;
  };

  # weird but otherwise the update service complains the directory is not owned by the same user
  programs.git.config.safe.directory = [ flakePath ];

  nix.gc = {
    automatic = true;
    persistent = false;
    dates = "daily";
    options = "--delete-older-than 30d";
  };
}
