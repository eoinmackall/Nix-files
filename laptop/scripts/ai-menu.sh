#!/usr/bin/env bash

Menu_option=$(echo -e "Claude
Gemini
Local" | noctalia dmenu -p "LLM Provider")

case "$Menu_option" in
	
	"Claude")
		firefox "https://claude.ai/";;

	"Gemini")
		firefox "https://gemini.google.com/";;

    "Local")
        firefox "https://localhost:8080";;
	
esac
