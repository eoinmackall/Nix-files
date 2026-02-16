{config, pkgs, ...}:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
      };
      
      animations = {
        enabled = true;
	bezier = "linear, 1, 1, 0, 0";
        animation = [
	  "fadeIn, 1, 4, linear"
	  "fadeOut, 1, 2, linear"
	  "inputFieldDots, 1, 2, linear"
	];
      };

       
      background = {
        monitor = "";
        path = "/home/eoinm/Pictures/Wallpapers/nix-d-nord-aurora.png";
        blur_passes = 2;
        # brightness = 0.5;
      };

      input-field = {
        monitor = "";
        size = "400, 80";
        position = "0, 0";
        halign = "center";
        valign = "center";

        inner_color = "rgb(36,39,58)";
        outer_color = "rgb(202,211,245)"; # #d3c6aa
        outline_thickness = 3;

        font_family = "UbuntuMono Nerd Font Mono";
        font_color = "rgb(165,173,206)";

        placeholder_text = "Enter Password";
        check_color = "rgba(131, 192, 146, 1.0)";
        fail_text = "Wrong";

        rounding = 0;
        shadow_passes = 0;
        fade_on_empty = false;
      };

      label = [
      {
        monitor = "";
        text = "\$TIME";
        text_align = "center";
        color = "rgb(165,173,206)";
        font_size = 140;
        font_family = "UbuntuMono Nerd Font Mono";
        position = "0, 250";
        halign = "center";
        valign = "center";
      }
      {
        monitor = "";
        text = ''cmd[update:60000] date +"%A, %d %B %Y"'';
        text_align = "center";
        color = "rgb(165,173,206)";
        font_size = 30;
        font_family = "UbuntuMono Nerd Font Mono";
        position = "0, 120";
        halign = "center";
        valign = "center";
      }
      ];
    };
  };
} 
