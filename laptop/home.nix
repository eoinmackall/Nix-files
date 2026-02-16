{ config, pkgs, ... }:

{
  home.username = "eoinm";
  home.homeDirectory = "/home/eoinm";
 
  imports = [
    ./hyprland/hyprland-configuration.nix
    ./hyprland/hyprlock-configuration.nix
    ./neovim/neovim-configuration.nix
    ./waybar/waybar-configuration.nix
    ./tofi/tofi-configuration.nix
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
	  on-timeout = "systemctl suspend-then-hibernate";
        }
      ];
    };
   };

  services.mako.enable = true;

  # Packages that should be installed to the user profile.
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
      matplotlib
    ]))
    (texliveMedium.withPackages (
      PackageSet: with PackageSet; [
        #Write package names here if needed
	]
      ))
    thunderbird
  ];

  home.shellAliases = {
    # This automatically injects the library every time you type 'julia'
    julia = "LD_PRELOAD=/run/current-system/sw/share/nix-ld/lib/libquadmath.so.0 julia";
  }; 

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    settings = {
      user ={
        name = "eoinmackall";
        email = "eoinmackall@gmail.com";
      };
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    
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

   
  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
