{config, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "hyprsunset"
      "systemctl --user start graphical-session.target"
    ];

  };
}
