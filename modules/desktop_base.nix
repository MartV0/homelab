{ pkgs, username, ... }:
{
  imports =
    [ 
      ./common_base.nix
      ./terminal_dev.nix
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

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.windowManager.qtile.enable = true;
  services.xserver.enable = true;

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
    packages = with pkgs; [
      kdePackages.kate

      # qtile/wm packages
      arandr
      blueman
      brightnessctl
      flameshot
      font-manager
      lxappearance
      networkmanager
      networkmanagerapplet
      pavucontrol
      picom
      rofi
      xfce.thunar
      xwallpaper
      
      # terminal/shell stuff
      alacritty
      nerd-fonts.caskaydia-cove
      nerd-fonts.caskaydia-mono
      nerd-fonts.symbols-only

      # gui applications
      discord
      firefox
      gnucash
      kdePackages.filelight
      kdePackages.okular
      keepassxc
      nextcloud-client
      obs-studio
      qalculate-gtk
      rpi-imager
      thunderbird
      tor-browser
      vlc
      zathura
      
      # tools/utilities
      ffmpeg
      gparted
      kdePackages.partitionmanager
      pandoc
      texliveFull
      yt-dlp
      
      # driver stuff
      hplip
    ];
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    # kde stuff
    aspell
    aspellDicts.en
    aspellDicts.nl
    aspellDicts.en-computers
    aspellDicts.en-science
  ];

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

