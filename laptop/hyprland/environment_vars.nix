{config, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    env = [
      "HYPRCURSOR_THEME,rose-pine-hyprcursor"
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
    ];
  };
}
