{ config, pkgs, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Vilnius";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.edgaras = {
    isNormalUser = true;
    description = "Edgaras";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  users.defaultUserShell = pkgs.fish;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.xserver = {
    enable = true;
    displayManager.defaultSession = "none+herbstluftwm";
    windowManager.herbstluftwm = {
      enable = true;
    };
  };

  services.picom.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  services.xserver.screenSection = ''
    	Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
    	Option         "AllowIndirectGLXProtocol" "off"
    	Option         "TripleBuffer" "on"
  '';

  programs.fish.enable = true;


  environment.systemPackages = with pkgs; [
    vim
    wget
    htop
    bat
    git
    alacritty
    firefox
    xterm
    vscode
    pcmanfm
    polybar
    nitrogen
    conky
    rofi
    starship
    nodejs
    xorg.xwininfo #stremiofix

    maestral
    logseq

    cmake

    tor-browser-bundle-bin

    #entertainment
    streamlink
    streamlink-twitch-gui-bin
    chatterino2
    strawberry

    cataclysm-dda

    stremio

    #make shell for these?
    rustc
    cargo
    python3
    gnome.pomodoro

    gparted
    powertop
    nixpkgs-fmt #nix formatter

    flameshot
    keepassxc
    mpv
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "Iosevka" ]; })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
