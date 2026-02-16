{config, pkgs, ...}:

{ 
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = (builtins.readFile ./waybar-style/theme.css)+
            (builtins.readFile ./waybar-style/style.css);
    settings = {
      mainBar = {
        layer = "top";
	position = "top";
	spacing = 0;
	height = 32;
	modules-left = [
	  "hyprland/workspaces"
	];
	modules-center = [
	  "clock"
	];
	modules-right = [
	  "tray"
	  "bluetooth"
	  "network"
	  "cpu"
	  "pulseaudio"
	  "battery"
	  "custom/power"
	];
	
	"hyprland/workspaces" = {
	  on-click = "activate";
	  format = "{icon}";
	  format-icons = {
	    default = "";
	    "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            active = "󱓻";
            };
           persistent-workspaces = {
             "1" = [];
             "2" = [];
             "3" = [];
             "4" = [];
             "5" = [];
           };
        };
        
	cpu = {
          interval = 5;
          format = "󰍛 ";
          on-click = "kitty -e top";
        };
        
	clock = {
          smooth-scrolling-threshold = 7.5;
	  format = "{:%B %e, %I:%M %p}";
          #format-alt = "{:%d %B W%V %Y}";
	  on-click = "thunderbird";
	  #on-click-right = "mode";
	  tooltip = true;
          tooltip-format = "<tt>{calendar}</tt>";
	 calendar = {
           mode = "month";
           weeks-pos = "right";
           on-scroll = 1;
           format = {
             weeks = "<span color ='#C74040'>{}</span>";
	     today = "<span color='#41A1D1'>{}</span>";
           };
         }; 
          actions = {
	    on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
	  };
	};
        
	network = {
          format-icons = [" 󰤯 " " 󰤟 " " 󰤢 " " 󰤥 " " 󰤨 "];
          format = "{icon}";
          format-wifi = "{icon}";
          format-ethernet = "󰀂 ";
          format-disconnected = "󰖪 ";
          tooltip-format-wifi = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-disconnected = "Disconnected";
          interval = 3;
          nospacing = 1;
          on-click = "kitty -e nmtui";
        };
        
	battery = {
          interval = 5;
          format = "{icon} {capacity}%";
          format-discharging = "{icon} {capacity}%";
          format-charging = "{icon} {capacity}%";
          format-plugged = "";
          format-icons = {
            charging = [
              "󰁺󱐋"
              "󰁻󱐋"
              "󰁼󱐋"
              "󰁽󱐋"
              "󰁾󱐋"
              "󰁿󱐋"
              "󰂀󱐋"
              "󰂁󱐋"
              "󰂂󱐋"
              "󰁹󱐋"
            ];
            default = [
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
          };
          format-full = "Charged ";
          tooltip-format-discharging = "{power:>1.0f}W↓ {capacity}%";
          tooltip-format-charging = "{power:>1.0f}W↑ {capacity}%";
          states = {
            warning = 20;
            critical = 10;
          };
        };
        
	bluetooth = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-connected = "󰂯";
          tooltip-format = "Devices connected: {num_connections}";
          on-click = "blueberry";
        };
        
	pulseaudio = {
	class = "audio";
        format = "{icon}{volume}%";
        format-muted = "󰖁 ";
        format-icons = {
          headphone = "󰋋 ";
          headset = "󰋎 ";
          portable = "󰏲 ";
          car = "󰸛 ";
          default = ["󰕿 " "󰖀 " "󰕾 "];
        };
        scroll-step = 1;
        on-click = "pavucontrol";
        tooltip-format = "{desc} ({volume}%)";
	max-volume = 100;
        }; 
        
	tray = {spacing = 13;};
        
	power-profiles-daemon = {
          format = "{icon}";
          tooltip-format = "Power profile: {profile}";
          tooltip = true;
          format-icons = {
            power-saver = " 󰡳 ";
            balanced = " 󰊚 ";
            performance = " 󰡴 ";
          };
        };
        
	"custom/power" = {
	  tooltip = true;
	  tooltip-format = "Power Options";
	  format = "<span font='18'> ⏻ </span>";
	  on-click = "/etc/nixos/scripts/power-menu.sh";
	};
      };
    };
  };
}
  

