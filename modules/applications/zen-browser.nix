{ pkgs-unstable, ... }:
{
  environment.systemPackages = with pkgs-unstable; [ 
      flatpak-xdg-utils
  ];

  services.flatpak = {
    enable = true;
    packages = [
      "app.zen_browser.zen"
      "com.github.tchx84.Flatseal"
    ];
  };
  # These commands for keepassxc thingie
  # flatpak override --user --talk-name=org.freedesktop.Flatpak app.zen_browser.zen
  # flatpak override --user --filesystem=home app.zen_browser.zen
}

