{preferences,...}: {
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
      ".gnupg"
      ".ssh"
      ".nixops"
      ".local/share"
      ".mozilla"
      ".vscode"
      ".vscodium"
      ".var"
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
