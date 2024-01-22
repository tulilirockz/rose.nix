{config,...}:
with config.colorScheme.colors; ''
window {
    font-size: 16px;
    color: #${base05};
    background-color: rgba(0, 0, 0, 0.5);
}
button {
    background-repeat: no-repeat;
    background-position: center;
    background-size: 50%;
    border: 5px solid rgba(0,0,0,0);
    background-color: rgba(0, 0, 0, 0.5);
    margin: 5px;
    border-radius: 5px;
    transition: box-shadow 0.2s ease-in-out, background-color 0.2s ease-in-out;
}
button:hover {
    background-color: rgba(0,0,0,0.6);
}
button:focus {
    background-color: #${base00};
    border: 5px solid #${base06};
    border-radius: 5px;
    color: #${base05};
  }

#lock {
    background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png"));
}

#logout {
    background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png"));
}

#suspend {
    background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"));
}

#hibernate {
    background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png"));
}

#shutdown {
    background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"));
}

#reboot {
    background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"));
}
''
