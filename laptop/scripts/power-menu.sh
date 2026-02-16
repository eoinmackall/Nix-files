#!/usr/bin/env bash

Power_option=$(echo -e "Escape
Log out
Suspend
Reboot
Power off" | tofi)

case "$Power_option" in

	"Escape") 
		;;

	"Log out") 
		hyprlock;;

	"Suspend") 
		systemctl suspend-then-hibernate;;

	"Reboot") 
		systemctl reboot;;

	"Power off") 
		systemctl poweroff;;

esac

