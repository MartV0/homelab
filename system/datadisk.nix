{ config, lib, pkgs, inputs, ... }:
{
  fileSystems."/datadisk" = {
    device = "/dev/disk/by-label/datadisk";
    options = [ 
      "nofail" 
      # "uid=1001" # defined in configuration.nix as the user id of the main user (martijn)
      # "gid=100"
    ];
  };
}
