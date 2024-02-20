{...}: {
  home.persistence."/persist/home" = {
    directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      "OneDrive"
      "Games"
      ".gnupg"
      ".ssh"
      ".nixops"
      ".local/share/keyrings"
      ".local/share/atuin"
      ".local/share/zoxide"
      ".local/share/applications"
      ".local/share/containers"
      ".var"
      ".local/share/direnv"
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
    ];
    files = [
      ".screenrc"
    ];
    allowOther = true;
  };
}
