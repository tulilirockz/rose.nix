{ config, lib, ... }:
# Generated with nix run github:pjones/plasma-manager
let
  cfg = config.rose.programs.desktops.plasma;
in
{
  options.rose.programs.desktops.plasma.enable = lib.mkEnableOption "Plasma DE settings";

  config = lib.mkIf cfg.enable {
    programs.plasma = {
      enable = true;
      workspace = {
        theme = "breeze-dark";
        colorScheme = "BreezeDark";
        wallpaper = "${../../../../assets/amiga.png}";
      };
      spectacle.shortcuts = {
        captureRectangularRegion = "Print";
      };
      shortcuts = {
        "ActivityManager"."switch-to-activity-79141c2b-7712-493a-8c41-1e2a4583fefe" = [ ];
        "KDE Keyboard Layout Switcher"."Switch to Last-Used Keyboard Layout" = "Meta+Alt+L";
        "KDE Keyboard Layout Switcher"."Switch to Next Keyboard Layout" = "Meta+Alt+K";
        "kaccess"."Toggle Screen Reader On and Off" = "Meta+Alt+S";
        "kcm_touchpad"."Disable Touchpad" = "Touchpad Off";
        "kcm_touchpad"."Enable Touchpad" = "Touchpad On";
        "kcm_touchpad"."Toggle Touchpad" = [
          "Touchpad Toggle"
          "Meta+Ctrl+Zenkaku Hankaku"
        ];
        "ksmserver"."Halt Without Confirmation" = [ ];
        "ksmserver"."Lock Session" = [
          "Meta+L"
          "Screensaver"
        ];
        "ksmserver"."Log Out" = "Ctrl+Alt+Del";
        "ksmserver"."Log Out Without Confirmation" = [ ];
        "ksmserver"."Reboot" = [ ];
        "ksmserver"."Reboot Without Confirmation" = [ ];
        "ksmserver"."Shut Down" = [ ];
        "kwin"."Activate Window Demanding Attention" = "Meta+Ctrl+A";
        "kwin"."Cycle Overview" = [ ];
        "kwin"."Cycle Overview Opposite" = [ ];
        "kwin"."Decrease Opacity" = [ ];
        "kwin"."Edit Tiles" = [ ];
        "kwin"."Expose" = "Ctrl+F9";
        "kwin"."ExposeAll" = [
          "Ctrl+F10"
          "Launch (C)"
        ];
        "kwin"."ExposeClass" = "Ctrl+F7";
        "kwin"."ExposeClassCurrentDesktop" = [ ];
        "kwin"."Grid View" = "Meta+G";
        "kwin"."Increase Opacity" = [ ];
        "kwin"."Kill Window" = "Meta+Ctrl+Esc";
        "kwin"."Move Tablet to Next Output" = [ ];
        "kwin"."MoveMouseToCenter" = "Meta+F6";
        "kwin"."MoveMouseToFocus" = "Meta+F5";
        "kwin"."MoveZoomDown" = [ ];
        "kwin"."MoveZoomLeft" = [ ];
        "kwin"."MoveZoomRight" = [ ];
        "kwin"."MoveZoomUp" = [ ];
        "kwin"."Overview" = "Meta+W";
        "kwin"."Setup Window Shortcut" = [ ];
        "kwin"."Show Desktop" = "Meta+D";
        "kwin"."Switch One Desktop Down" = "Meta+Ctrl+Down";
        "kwin"."Switch One Desktop Up" = "Meta+Ctrl+Up";
        "kwin"."Switch One Desktop to the Left" = "Meta+Ctrl+Left";
        "kwin"."Switch One Desktop to the Right" = "Meta+Ctrl+Right";
        "kwin"."Switch Window Down" = "Meta+Alt+Down";
        "kwin"."Switch Window Left" = "Meta+Alt+Left";
        "kwin"."Switch Window Right" = "Meta+Alt+Right";
        "kwin"."Switch Window Up" = "Meta+Alt+Up";
        "kwin"."Switch to Desktop 1" = "Meta+F1";
        "kwin"."Switch to Desktop 2" = "Meta+F2";
        "kwin"."Switch to Desktop 3" = "Meta+F3";
        "kwin"."Switch to Desktop 4" = "Meta+F4";
        "kwin"."Switch to Desktop 5" = "Meta+F5";
        "kwin"."Switch to Desktop 6" = "Meta+F6";
        "kwin"."Switch to Desktop 7" = "Meta+F7";
        "kwin"."Switch to Desktop 8" = "Meta+F8";
        "kwin"."Switch to Desktop 9" = "Meta+F9";
        "kwin"."Switch to Next Desktop" = [ ];
        "kwin"."Switch to Next Screen" = [ ];
        "kwin"."Switch to Previous Desktop" = [ ];
        "kwin"."Switch to Previous Screen" = [ ];
        "kwin"."Switch to Screen 0" = [ ];
        "kwin"."Switch to Screen 1" = [ ];
        "kwin"."Switch to Screen 2" = [ ];
        "kwin"."Switch to Screen 3" = [ ];
        "kwin"."Switch to Screen 4" = [ ];
        "kwin"."Switch to Screen 5" = [ ];
        "kwin"."Switch to Screen 6" = [ ];
        "kwin"."Switch to Screen 7" = [ ];
        "kwin"."Switch to Screen Above" = [ ];
        "kwin"."Switch to Screen Below" = [ ];
        "kwin"."Switch to Screen to the Left" = [ ];
        "kwin"."Switch to Screen to the Right" = [ ];
        "kwin"."Toggle Night Color" = [ ];
        "kwin"."Toggle Window Raise/Lower" = [ ];
        "kwin"."Walk Through Windows" = "Alt+Tab";
        "kwin"."Walk Through Windows (Reverse)" = "Alt+Shift+Tab";
        "kwin"."Walk Through Windows Alternative" = [ ];
        "kwin"."Walk Through Windows Alternative (Reverse)" = [ ];
        "kwin"."Walk Through Windows of Current Application" = "Alt+`";
        "kwin"."Walk Through Windows of Current Application (Reverse)" = "Alt+~";
        "kwin"."Walk Through Windows of Current Application Alternative" = [ ];
        "kwin"."Walk Through Windows of Current Application Alternative (Reverse)" = [ ];
        "kwin"."Window Above Other Windows" = [ ];
        "kwin"."Window Below Other Windows" = [ ];
        "kwin"."Window Close" = [
          "Alt+F4"
          "Meta+C"
        ];
        "kwin"."Window Fullscreen" = "Meta+X";
        "kwin"."Window Grow Horizontal" = [ ];
        "kwin"."Window Grow Vertical" = [ ];
        "kwin"."Window Lower" = [ ];
        "kwin"."Window Maximize" = "Meta+V";
        "kwin"."Window Maximize Horizontal" = [ ];
        "kwin"."Window Maximize Vertical" = [ ];
        "kwin"."Window Minimize" = "Meta+PgDown";
        "kwin"."Window Move" = [ ];
        "kwin"."Window Move Center" = [ ];
        "kwin"."Window No Border" = [ ];
        "kwin"."Window On All Desktops" = [ ];
        "kwin"."Window One Desktop Down" = "Meta+Ctrl+Shift+Down";
        "kwin"."Window One Desktop Up" = "Meta+Ctrl+Shift+Up";
        "kwin"."Window One Desktop to the Left" = "Meta+Ctrl+Shift+Left";
        "kwin"."Window One Desktop to the Right" = "Meta+Ctrl+Shift+Right";
        "kwin"."Window One Screen Down" = [ ];
        "kwin"."Window One Screen Up" = [ ];
        "kwin"."Window One Screen to the Left" = [ ];
        "kwin"."Window One Screen to the Right" = [ ];
        "kwin"."Window Operations Menu" = "Alt+F3";
        "kwin"."Window Pack Down" = [ ];
        "kwin"."Window Pack Left" = [ ];
        "kwin"."Window Pack Right" = [ ];
        "kwin"."Window Pack Up" = [ ];
        "kwin"."Window Quick Tile Bottom" = "Meta+Down";
        "kwin"."Window Quick Tile Bottom Left" = [ ];
        "kwin"."Window Quick Tile Bottom Right" = [ ];
        "kwin"."Window Quick Tile Left" = "Meta+Left";
        "kwin"."Window Quick Tile Right" = "Meta+Right";
        "kwin"."Window Quick Tile Top" = "Meta+Up";
        "kwin"."Window Quick Tile Top Left" = [ ];
        "kwin"."Window Quick Tile Top Right" = [ ];
        "kwin"."Window Raise" = [ ];
        "kwin"."Window Resize" = [ ];
        "kwin"."Window Shade" = [ ];
        "kwin"."Window Shrink Horizontal" = [ ];
        "kwin"."Window Shrink Vertical" = [ ];
        "kwin"."Window to Desktop 1" = [ ];
        "kwin"."Window to Desktop 10" = [ ];
        "kwin"."Window to Desktop 11" = [ ];
        "kwin"."Window to Desktop 12" = [ ];
        "kwin"."Window to Desktop 13" = [ ];
        "kwin"."Window to Desktop 14" = [ ];
        "kwin"."Window to Desktop 15" = [ ];
        "kwin"."Window to Desktop 16" = [ ];
        "kwin"."Window to Desktop 17" = [ ];
        "kwin"."Window to Desktop 18" = [ ];
        "kwin"."Window to Desktop 19" = [ ];
        "kwin"."Window to Desktop 2" = [ ];
        "kwin"."Window to Desktop 20" = [ ];
        "kwin"."Window to Desktop 4" = [ ];
        "kwin"."Window to Desktop 5" = [ ];
        "kwin"."Window to Desktop 6" = [ ];
        "kwin"."Window to Desktop 7" = [ ];
        "kwin"."Window to Desktop 8" = [ ];
        "kwin"."Window to Desktop 9" = [ ];
        "kwin"."Window to Next Desktop" = [ ];
        "kwin"."Window to Next Screen" = "Meta+Shift+Right";
        "kwin"."Window to Previous Desktop" = [ ];
        "kwin"."Window to Previous Screen" = "Meta+Shift+Left";
        "kwin"."Window to Screen 0" = [ ];
        "kwin"."Window to Screen 1" = [ ];
        "kwin"."Window to Screen 2" = [ ];
        "kwin"."Window to Screen 3" = [ ];
        "kwin"."Window to Screen 4" = [ ];
        "kwin"."Window to Screen 5" = [ ];
        "kwin"."Window to Screen 6" = [ ];
        "kwin"."Window to Screen 7" = [ ];
        "kwin"."view_actual_size" = "Meta+0";
        "kwin"."view_zoom_in" = [
          "Meta++"
          "Meta+="
        ];
        "kwin"."view_zoom_out" = "Meta+-";
        "mediacontrol"."mediavolumedown" = [ ];
        "mediacontrol"."mediavolumeup" = [ ];
        "mediacontrol"."nextmedia" = "Media Next";
        "mediacontrol"."pausemedia" = "Media Pause";
        "mediacontrol"."playmedia" = [ ];
        "mediacontrol"."playpausemedia" = "Media Play";
        "mediacontrol"."previousmedia" = "Media Previous";
        "mediacontrol"."stopmedia" = "Media Stop";
        "org_kde_powerdevil"."Decrease Keyboard Brightness" = "Keyboard Brightness Down";
        "org_kde_powerdevil"."Decrease Screen Brightness" = "Monitor Brightness Down";
        "org_kde_powerdevil"."Decrease Screen Brightness Small" = "Shift+Monitor Brightness Down";
        "org_kde_powerdevil"."Hibernate" = "Hibernate";
        "org_kde_powerdevil"."Increase Keyboard Brightness" = "Keyboard Brightness Up";
        "org_kde_powerdevil"."Increase Screen Brightness" = "Monitor Brightness Up";
        "org_kde_powerdevil"."Increase Screen Brightness Small" = "Shift+Monitor Brightness Up";
        "org_kde_powerdevil"."PowerDown" = "Power Down";
        "org_kde_powerdevil"."PowerOff" = "Power Off";
        "org_kde_powerdevil"."Sleep" = "Sleep";
        "org_kde_powerdevil"."Toggle Keyboard Backlight" = "Keyboard Light On/Off";
        "org_kde_powerdevil"."Turn Off Screen" = [ ];
        "org_kde_powerdevil"."powerProfile" = [
          "Battery"
          "Meta+B"
        ];
        "plasmashell"."activate task manager entry 1" = "Meta+1";
        "plasmashell"."activate task manager entry 10" = [ ];
        "plasmashell"."activate task manager entry 2" = "Meta+2";
        "plasmashell"."activate task manager entry 3" = "Meta+3";
        "plasmashell"."activate task manager entry 4" = "Meta+4";
        "plasmashell"."activate task manager entry 5" = "Meta+5";
        "plasmashell"."activate task manager entry 6" = "Meta+6";
        "plasmashell"."activate task manager entry 7" = "Meta+7";
        "plasmashell"."activate task manager entry 8" = "Meta+8";
        "plasmashell"."activate task manager entry 9" = "Meta+9";
        "plasmashell"."clear-history" = [ ];
        "plasmashell"."clipboard_action" = "Meta+Ctrl+X";
        "plasmashell"."cycle-panels" = "Meta+Alt+P";
        "plasmashell"."cycleNextAction" = [ ];
        "plasmashell"."cyclePrevAction" = [ ];
        "plasmashell"."manage activities" = [ ];
        "plasmashell"."next activity" = "Meta+A";
        "plasmashell"."previous activity" = "Meta+Shift+A";
        "plasmashell"."repeat_action" = [ ];
        "plasmashell"."show dashboard" = "Ctrl+F12";
        "plasmashell"."show-barcode" = [ ];
        "plasmashell"."show-on-mouse-pos" = "Meta+V";
        "plasmashell"."stop current activity" = "Meta+S";
        "plasmashell"."switch to next activity" = [ ];
        "plasmashell"."switch to previous activity" = [ ];
        "plasmashell"."toggle do not disturb" = [ ];
        "services.org.kde.konsole.desktop"."_launch" = "Meta+T";
        "chromium-browser.desktop"."_launch" = "Meta+F";
      };
      configFile = {
        "baloofilerc"."Basic Settings"."Indexing-Enabled" = false;
        "dolphinrc"."KFileDialog Settings"."Places Icons Auto-resize" = false;
        "dolphinrc"."KFileDialog Settings"."Places Icons Static Size" = 22;
        "kactivitymanagerdrc"."activities"."79141c2b-7712-493a-8c41-1e2a4583fefe" = "Default";
        "kactivitymanagerdrc"."main"."currentActivity" = "79141c2b-7712-493a-8c41-1e2a4583fefe";
        "kcminputrc"."Keyboard"."RepeatDelay" = 250;
        "kcminputrc"."Keyboard"."RepeatRate" = 60;
        "kcminputrc"."Libinput.1133.16468.Logitech Wireless Mouse"."PointerAcceleration" = 0.15;
        "kcminputrc"."Libinput.1133.16468.Logitech Wireless Mouse"."PointerAccelerationProfile" = 1;
        "kded5rc"."Module-device_automounter"."autoload" = false;
        "kdeglobals"."General"."XftHintStyle" = "hintslight";
        "kdeglobals"."General"."XftSubPixel" = "none";
        "kdeglobals"."General"."fixed" = "IntoneMono Nerd Font Mono,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
        "kdeglobals"."WM"."activeBackground" = "49,54,59";
        "kdeglobals"."WM"."activeBlend" = "252,252,252";
        "kdeglobals"."WM"."activeForeground" = "252,252,252";
        "kdeglobals"."WM"."inactiveBackground" = "42,46,50";
        "kdeglobals"."WM"."inactiveBlend" = "161,169,177";
        "kdeglobals"."WM"."inactiveForeground" = "161,169,177";
        "kglobalshortcutsrc"."ActivityManager"."_k_friendly_name" = "Activity Manager";
        "kglobalshortcutsrc"."KDE Keyboard Layout Switcher"."_k_friendly_name" = "Keyboard Layout Switcher";
        "kglobalshortcutsrc"."kaccess"."_k_friendly_name" = "Accessibility";
        "kglobalshortcutsrc"."kcm_touchpad"."_k_friendly_name" = "Touchpad";
        "kglobalshortcutsrc"."ksmserver"."_k_friendly_name" = "KWin";
        "kglobalshortcutsrc"."kwin"."_k_friendly_name" = "KWin";
        "kglobalshortcutsrc"."mediacontrol"."_k_friendly_name" = "Media Controller";
        "kglobalshortcutsrc"."org_kde_powerdevil"."_k_friendly_name" = "Power Management";
        "kglobalshortcutsrc"."plasmashell"."_k_friendly_name" = "plasmashell";
        "kwalletrc"."Wallet"."First Use" = false;
        "kwinrc"."Desktops"."Id_1" = "a3fd07e3-059b-40a7-8041-5f7ffd51fb51";
        "kwinrc"."Desktops"."Id_2" = "668b8c5a-928f-4bfa-aaef-30bb7c841a4b";
        "kwinrc"."Desktops"."Id_3" = "b2f06ec8-5321-49d9-a34a-66faf4d55a4c";
        "kwinrc"."Desktops"."Id_4" = "22cc02f9-1b07-4363-86ad-a8f745940fb5";
        "kwinrc"."Desktops"."Number" = 4;
        "kwinrc"."Desktops"."Rows" = 2;
        "kwinrc"."Plugins"."desktopchangeosdEnabled" = true;
        "kwinrc"."Plugins"."fadedesktopEnabled" = true;
        "kwinrc"."Plugins"."slideEnabled" = false;
        "kwinrc"."Script-desktopchangeosd"."PopupHideDelay" = 500;
        "kwinrc"."Tiling"."padding" = 4;
        "kwinrc"."Tiling.d3b153ee-5d4a-5046-a2e9-ded4dc797d82"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Xwayland"."Scale" = 1;
        "plasma-localerc"."Formats"."LANG" = "en_US.UTF-8";
      };
    };
  };
}
