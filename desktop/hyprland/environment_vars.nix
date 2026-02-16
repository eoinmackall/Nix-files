{config, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    env = [
      "HYPRCURSOR_THEME,rose-pine-hyprcursor"
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
      "XDG_SESSION_TYPE,wayland"
      "LIBVA_DRIVER_NAME,nvidia"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "GBM_BACKEND,nvidia-drm"
    ];
  };
}
