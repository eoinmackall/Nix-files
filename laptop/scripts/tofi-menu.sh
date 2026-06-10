#!/usr/bin/env bash

Menu_option=$(echo -e "Bolt
Canvas
Firefox
Gemini
Julia
Keybindings
NixOS Manual
Overleaf
Yazi" | tofi)

case "$Menu_option" in

	"Bolt")
		flatpak run com.adamcake.Bolt;;

	"Canvas") 
		firefox "https://its.ucsc.edu/services/teaching-and-learning/learning-management/canvas-learning-management-system/";;

	"Firefox") 
		firefox;;

	"Gemini")
		firefox "https://gemini.google.com/app";;
	
	"Julia") 
		kitty -e env LD_PRELOAD=/run/current-system/sw/share/nix-ld/lib/libquadmath.so.0 julia;;
	
	"Keybindings") 
		exec /etc/nixos/scripts/keybindings/keybindings-menu.sh;;

	"NixOS Manual") 
		nixos-help;;
	
	"Overleaf")
		firefox "https://www.overleaf.com/";;
	
	"Yazi")
		kitty -e yazi;;

esac
