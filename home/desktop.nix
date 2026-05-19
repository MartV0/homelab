{ pkgs, lib, config, ... }:
{
  config = lib.mkIf config.isDesktop {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
    };

    # Needed because enabling a gtk theme keeps creating an old file
    home.activation.removeGtkRc = {
      data = "rm -f $HOME/.gtkrc-2.0";
      before = [ "checkLinkTargets" ];
      after = [ ];
    };

    qt = {
      enable = true;
      platformTheme.name = "adwaita";
      style = {
          name = "Adwaita-dark";
          package = pkgs.gnome-themes-extra;
        };
    };

    xdg.desktopEntries.tidal-hifi = {
      name = "TIDAL Hi-Fi";
      # --no-sandbox is needed, otherwise white screen
      exec = "tidal-hifi --no-sandbox";
      icon = "tidal-hifi";
      terminal = false;
    };
  };
}
