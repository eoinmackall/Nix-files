{config, pkgs, ...}:

{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "HDMI-A-1,preferred,auto-right,auto"
      "DP-1,preferred,auto-left,auto"
    ];
  };
}
