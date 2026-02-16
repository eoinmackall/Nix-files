{config, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # Example windowrule
      # "float,class:^(kitty)$,title:^(kitty)$"

      # Ignore maximize requests from apps. You'll probably like this.
      # "suppressevent maximize, class:.*"

      # Fix some dragging issues with XWayland
      # "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
    ];
    workspace = [
      "1, monitor:DP-1, default:true"
      "2, monitor:HDMI-A-1, default:true"
    ];
  };
}
