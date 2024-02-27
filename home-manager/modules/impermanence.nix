{preferences, ...}: {
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
      ".tldrc"
      ".cache/nvim"
      ".cache/pre-commit"
      ".config/carapace"
      ".config/lazygit"
      ".config/libvirt"
      ".cache/chromium"
      ".config/chromium"
      ".local/state/wireplumber"
      ".local/state/nvim"
      ".local/share/atuin"
      ".local/share/go"
      ".local/share/flatpak"
      ".local/share/keyrings"
      ".local/share/zoxide"
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
