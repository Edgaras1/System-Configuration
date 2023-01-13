{ config, pkgs, ... }:

{
  home.username = "edgaras";
  home.homeDirectory = "/home/edgaras";

  home.packages = with pkgs;[
    playerctl #control media
  ];

  programs.ncmpcpp = {
    enable = true;
  };

  # systemctl start mopidy-scan.service to scan local files
  services.mopidy = {
    enable = true;

    extensionPackages = with pkgs; [
      mopidy-ytmusic
      mopidy-mpd
      mopidy-local
      mopidy-mpris
    ];
    settings = {
      mpd = {
        enabled = true;
        hostname = "127.0.0.1";
        port = 6600;
      };
      mopidy-ytmusic = {
        enable = true;
      };
      mopidy-local = { };
      mpris = {
        enabled = true;
        bus_type = "sessions"; #"system"

      };
    };
  };

  # services.gpg-agent = {
  #   enable = true;
  #   defaultCacheTtl = 1800;
  #   enableSshSupport = true;
  # };

  programs.home-manager.enable = true;
  home.stateVersion = "22.11";
}
