{ lib, config, ... }:
{
  options.plymouth-screen.enable = lib.options.mkEnableOption "plymouth boot screen";

  config = lib.mkIf config.plymouth-screen.enable {
    boot = {
      plymouth = {
        enable = true;
        theme = "breeze";
      };

      # Enable "Silent boot"
      consoleLogLevel = 3;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "rd.udev.log_level=3"
        "rd.systemd.show_status=auto"
      ];

      # disable boot menu
      # loader.timeout = 0;
    };
  };
}
