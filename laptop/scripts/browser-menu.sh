#!/usr/bin/env bash

Menu_option=$(echo -e "Canvas
Julia
Keybindings
Overleaf" | noctalia dmenu -p "Shortcuts")

case "$Menu_option" in

	"Canvas") 
		firefox "https://its.ucsc.edu/services/teaching-and-learning/learning-management/canvas-learning-management-system/";;

	"Julia") 
		kitty -e env LD_PRELOAD=/run/current-system/sw/share/nix-ld/lib/libquadmath.so.0 julia;;
	
	"Keybindings") 
		exec /etc/nixos/scripts/keybindings/keybindings-menu.sh;;

	"Overleaf")
		firefox "https://www.overleaf.com/";;
	
esac
