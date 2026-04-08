{ pkgs, username, pkgs-unstable, nix-flatpak, ... }:
{
  imports =
    [ 
      ./common_base.nix
      ./terminal_dev.nix
      ./applications/vpn.nix
      ./applications/zen-browser.nix
      ./window_managers/kde.nix
      ./window_managers/niri.nix
      nix-flatpak.nixosModules.nix-flatpak 
    ];

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.users."${username}" = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  programs.firefox.enable = true;

  environment.systemPackages = let 
    unstable = with pkgs-unstable; [ 
      seadrive-gui
      tidal-hifi
    ]; 
    in 
    with pkgs; [
      # terminal/shell stuff
      alacritty
      nerd-fonts.caskaydia-cove
      nerd-fonts.caskaydia-mono
      nerd-fonts.symbols-only
      nerd-fonts.jetbrains-mono

      # gui applications
      discord
      signal-desktop
      firefox
      gnucash
      kdePackages.filelight
      kdePackages.okular
      keepassxc
      libreoffice
      marktext
      obs-studio
      qalculate-gtk
      rpi-imager
      thunderbird
      tor-browser
      vlc
      pragha
      krita
      pinta
      zathura
      xdotool # required by zathura for forward search
      seafile-client
      localsend
      emacs-gtk
      qbittorrent

      # uni stuff
      zotero
      jetbrains.idea
      teams-for-linux
      
      # tools/utilities
      ffmpeg
      gparted
      kdePackages.partitionmanager
      pandoc
      texliveFull
      yt-dlp
      gnome-disk-utility
      
      # driver stuff
      hplip
  ] ++ unstable;

  # autostart seadrive
  systemd.user.services.seadrive = {
    path = [ pkgs-unstable.seadrive-gui ];
    description = "Autostart seadrive";
    wantedBy = [ "niri.service" ];
    wants = [ "niri.service" ];
    after = [ "niri.service" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs-unstable.seadrive-gui}/bin/seadrive-gui";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  system.stateVersion = "24.11";
}

