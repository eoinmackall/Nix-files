#!/usr/bin/env bash

Menu_option=$(echo -e "System
Yazi" | tofi)

case "$Menu_option" in

	"System")
		kitty -e nvim /etc/nixos/hyprland/keybindings.nix;;

	"Yazi")
		kitty -e nvim /etc/nixos/scripts/keybindings/yazi-keybindings;;

esac

