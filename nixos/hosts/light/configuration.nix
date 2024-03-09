{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/managed-desktops.nix
    ../../modules/std.nix
    ../../modules/sunshine.nix
    ../../modules/virtual.nix
    ../../modules/user.nix
  ];

  system.stateVersion = "24.05";

  boot.loader.systemd-boot.enable = true;

  networking.hostName = "light";

  system.desktop.enable = true;
  system.desktop.wm.enable = true;
  system.desktop.niri.enable = true;

  virtualisation.managed.enable = true;

  environment.systemPackages = with pkgs; [ acpi powertop ];

  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };
  services.thermald.enable = true;

  services.udev.extraRules = ''SUBSYSTEM=="input", KERNEL=="event[0-9]*", ENV{ID_INPUT_TOUCHSCREEN}=="1", ENV{WL_OUTPUT}="silead_ts", ENV{LIBINPUT_CALIBRATION_MATRIX}="2.0994971271086835 0.0 -0.009475882227217559 0.0 3.2251959199264215 -0.002555450541782298 0.0 0.0 1.0"'';

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
    driSupport = true;
    driSupport32Bit = true;
  };
}
