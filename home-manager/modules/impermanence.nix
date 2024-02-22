{
  preferences,
  config,
  ...
}: {
  home.persistence."/persist/home/${preferences.main_username}" = {
    directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      "OneDrive"
      "Games"
      "opt"
      "go"
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
      "${config.home.sessionVariables.GOPATH}"
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
      {
        directory = ".local/share/containers";
        method = "symlink";
      }
    ];
    allowOther = true;
  };
}
