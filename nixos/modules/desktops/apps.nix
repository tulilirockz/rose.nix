{ pkgs, ... }: {
  gnomeApps =
    (with pkgs.gnome; [
      gnome-tweaks
      dconf-editor
      nautilus
      totem
      sushi
      gnome-weather
      gnome-calendar
      gnome-clocks
      gnome-calculator
      gnome-system-monitor
      gnome-tweaks
    ])
    ++ (with pkgs; [
      shortwave
      gitg
      dconf-editor
      polari
      transmission-gtk
      gnome-solanum
      gitg
      gradience
      impression
      amberol
      baobab
      blanket
      snapshot
      loupe
      gnome-firmware
      gnome-podcasts
      newsflash
    ]);

  sharedApps = with pkgs; [
    cinny-desktop
    thunderbird
    adw-gtk3
    helvum
    pavucontrol
    libreoffice
    catppuccin-gtk
    stremio
    mumble
    gnome-podcasts
    newsflash
    thunderbird
    monophony
    shortwave
    gnome.gnome-clocks
  ];

  qtApps = with pkgs; [
    libsForQt5.kclock
    libsForQt5.alligator
    libsForQt5.kamoso
    libsForQt5.kasts
    libsForQt5.kolourpaint
    libsForQt5.kweather
    qpwgraph
    vlc
    keepassxc
    qbittorrent
  ];

  wmApps = with pkgs; [
    wlay
    blueman
    mpv
    zathura
    newsboat
    imv
    kanshi
    wl-clipboard
    mediainfo
    exiftool
    transmission-gtk
    gnome.nautilus
    swayimg
  ];
}
