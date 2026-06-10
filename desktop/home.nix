{ config, pkgs, ... }:

{
  home.username = "eoinm";
  home.homeDirectory = "/home/eoinm";

  imports = [
    ./hyprland/hyprland-configuration.nix
    ./hyprland/hyprlock-configuration.nix
    ./neovim/neovim-configuration.nix
  ];

  services.ssh-agent.enable = true;
  
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
	before_sleep_cmd = "loginctl lock-session";
	after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
	  timeout=600;
	  on-timeout = "loginctl lock-session";
	}
	{
	  timeout = 660;
	  on-timeout = "hyprctl dispatch dpms off";
	  on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
	}
	{
	  timeout = 1800;
	  on-timeout = "systemctl suspend";
        }
      ];
    };
  };


  home.packages = with pkgs; [
    openssh
    ripgrep
    julia
    gap-full
    singular
    polymake
    flint
    (python3.withPackages (python-pkgs: with python-pkgs; [
      jupyter
      pandas
      matplotlib
    ]))
    (texliveMedium.withPackages (
      PackageSet: with PackageSet; [
        geometry
        xcolor
        multirow
	tools
        enumitem
        soul
      ]
    ))
  ];

  home.shellAliases = {
    julia = "LD_PRELOAD=/run/current-system/sw/share/nix-ld/lib/libquadmath.so.0 julia";
  }; 

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Eoin Mackall";
        email = "eoinmackall@gmail.com";
      };
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'
    '';
  };

  programs.kitty = {
    enable = true;
    themeFile = "gruvbox-dark-hard";
    settings = {
      background_opacity = 0.6;
      confirm_os_window_close = -1;
    };
    keybindings = {
      "ctrl+shift+n" = "new_os_window_with_cwd";
    };
  };

  programs.obs-studio = {
    enable = true;

    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
    ];
  };

  home.stateVersion = "25.11";
}
