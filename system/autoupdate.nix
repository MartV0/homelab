{ config, lib, pkgs, inputs, ... }:
{
  system.autoUpgrade = {
    enable = true;
    dates = "03:00";
    flake = inputs.self.outPath;
    flags = [
        "--update-input" "nixpkgs"
    ];
    allowReboot = true;
  };

  nix.gc = {
    automatic = true;
    persistent = false;
    dates = "daily";
    options = "--delete-older-than 30d";
  };
}
