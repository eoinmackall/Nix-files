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
        path = "/home/eoinm/Pictures/Wallpapers/520180.jpg";
        blur_passes = 2;
        # brightness = 0.5;
      };

      input-field = {
        monitor = "HDMI-A-1";
        size = "400, 60";
        position = "0, 0";
        halign = "center";
        valign = "center";

        inner_color = "rgba(26,173,214,0.3)";
        outer_color = "rgb(0,0,0)";
        outline_thickness = 3;

        font_family = "UbuntuMono Nerd Font Mono";
        font_color = "rgb(0,0,0)";

        placeholder_text = "Enter Password";
        check_color = "rgba(131, 192, 146, 1.0)";
        fail_text = "Wrong";

        rounding = 0;
        shadow_passes = 4;
        fade_on_empty = false;
      };

      label = [
        {
          monitor = "HDMI-A-1";
          text = "\$TIME";
          text_align = "center";
          color = "rgb(0,0,0)";
          font_size = 100;
          font_family = "UbuntuMono Nerd Font Mono";
          position = "0, 200";
          halign = "center";
          valign = "center";
	  shadow_passes = 4;
        }
        {
          monitor = "HDMI-A-1";
          text = ''cmd[update:60000] date +"%A, %d %B %Y"'';
          text_align = "center";
          color = "rgb(0,0,0)";
          font_size = 30;
          font_family = "UbuntuMono Nerd Font Mono";
          position = "0, 110";
          halign = "center";
          valign = "center";
	  shadow_passes = 4;
        }
      ];
    };
  };
} 
