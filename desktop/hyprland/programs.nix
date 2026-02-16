{config, pkgs, ...}:

{
  wayland.windowManager.hyprland.settings = {
    "$terminal" = "kitty";
    "$fileManager" = "kitty -e yazi";
    "$browser" = "MOZ_ENABLE_WAYLAND=1 firefox --new-window";
  };
}
