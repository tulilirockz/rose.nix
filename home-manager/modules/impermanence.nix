{ preferences, ... }: {
  home.persistence."/persist/home/${preferences.username}" = {
    allowOther = true;
    directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      "OneDrive"
      "Games"
      "opt"
      ".gnupg"
      ".ssh"
      ".nixops"
      ".mozilla"
      ".vscode"
      ".vscodium"
      ".var"
      ".cache/tldr"
      ".cache/NuGetPackages"
      ".cache/nvim"
      ".cache/cargo"
      ".cache/chromium"
      ".cache/pre-commit"
      ".cache/direnv"
      ".config/obs-studio"
      ".config/GIMP"
      ".config/carapace"
      ".config/nix"
      ".config/libresprite"
      ".config/heroic"
      ".config/gh"
      ".config/WebCord"
      ".config/lazygit"
      ".config/direnv"
      ".config/libvirt"
      ".config/onedrive"
      ".config/kdeconnect"
      ".config/chromium"
      ".config/epiphany"
      ".config/Bitwarden"
      ".local/share/flakehub"
      ".local/share/epiphany"
      ".local/share/in.cinny.app"
      ".local/share/cinny"
      ".local/state/wireplumber"
      ".local/state/nvim"
      ".local/share/atuin"
      ".local/share/go"
      ".local/share/flatpak"
      ".local/share/keyrings"
      ".local/share/zoxide"
      ".local/share/dotnet"
      ".local/share/direnv"
      ".local/share/nvim"
      ".local/share/krita"
      ".local/share/waydroid"
      {
        directory = ".local/share/gnome-boxes";
        method = "symlink";
      }
      {
        directory = ".local/share/containers";
        method = "symlink";
      }
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
    ];
  };
}
