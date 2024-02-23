{
  preferences,
  ...
}: {
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
      ".config/carapace"
      ".config/lazygit"
      ".local/state/wireplumber"
      ".local/share/atuin"
      ".local/share/flatpak"
      ".local/share/keyrings"
      ".local/share/zoxide"
      ".local/share/nvim"
      ".local/share/gopath"
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
