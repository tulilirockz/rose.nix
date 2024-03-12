{ preferences, ... }: {
  home.persistence."/persist/home/${preferences.main_username}" = {
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
      ".config/carapace"
      ".config/nix"
      ".config/heroic"
      ".config/gh"
      ".config/lazygit"
      ".config/direnv"
      ".config/libvirt"
      ".config/onedrive"
      ".config/kdeconnect"
      ".config/chromium"
      ".config/epiphany"
      ".local/share/flakehub"
      ".local/share/epiphany"
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
