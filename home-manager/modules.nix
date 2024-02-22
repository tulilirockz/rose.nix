{...}: let
  modulesPath = "modules";
in {
  imports = builtins.map (path: ./${modulesPath}/${path}) [
    "clitools.nix"
    "devtools.nix"
    "wm.nix"
    "browsers.nix"
  ];
}
