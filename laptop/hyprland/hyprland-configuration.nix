{ config, pkgs, ... }:

{
  imports = [
  ./autostart.nix
  ./environment_vars.nix
  ./input.nix
  ./keybindings.nix
  ./look_and_feel.nix
  ./monitors.nix
  ./permissions.nix
  ./programs.nix
  ./windows_and_workspaces.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    settings = {
      xwayland = {
       force_zero_scaling = true;
      };
    };
  };

  
  services.hyprpolkitagent.enable = true;
}
