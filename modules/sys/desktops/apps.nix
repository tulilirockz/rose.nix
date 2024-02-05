{pkgs, ...}: {
  gnomeApps =
    (with pkgs.gnome; [
      gnome-tweaks
      dconf-editor
      nautilus
      totem
      sushi
      gnome-weather
      gnome-clocks
      gnome-calendar
      gnome-calculator
      gnome-system-monitor
      gnome-tweaks
      gitg
      dconf-editor
      polari
    ])
    ++ (with pkgs; [
      newsflash
      shortwave
    ]);

  sharedApps = with pkgs; [
    inter
    adw-gtk3
    gradience
    gnome-podcasts
    transmission-gtk
    gnome-solanum
    gitg
    amberol
    nautilus-open-any-terminal
    baobab
    blanket
    audacity
    helvum
    snapshot
    gnome-firmware
    pavucontrol
    loupe
    cantarell-fonts
    fractal
    mumble
    impression
    onlyoffice-bin
    libreoffice
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
}
