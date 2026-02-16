{config, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "hyprsunset"
      "swaybg -i /home/eoinm/Pictures/Wallpapers/nix-d-nord-aurora.svg -m center"
      "systemctl --user start graphical-session.target"
    ];

  };
}
