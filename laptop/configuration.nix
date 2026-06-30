{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Hardware
  hardware.bluetooth.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
 
  # Nix-features
  nix.settings.experimental-features = [ "nix-command" "flakes"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Networking 
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
 
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Battery monitor
  services.upower.enable = true;

  #Enables power-profiles (balanced, power-saver, etc.)
  services.power-profiles-daemon.enable = true;
  
  # Login greeter
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
    extraPackages = with pkgs; [
      kdePackages.qtmultimedia
    ];
    theme = "sddm-astronaut-theme";
  }; 
  
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
 
  #Enables D-bus (communication middleware)
  services.dbus.enable = true;

  #Enables automatic disk mounting
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  #Enables Flatpaks/Flathub
  services.flatpak.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.eoinm = {
    isNormalUser = true;
    description = "Eoin Mackall";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };
     
  # System packages
  environment.systemPackages = with pkgs; [
    wget
    git
    neovim
    wl-clipboard
    kitty
    yazi
    tofi
    pavucontrol
    hyprcursor
    hyprlock
    hypridle
    hyprshot
    hyprsunset
    brightnessctl
    rose-pine-hyprcursor
    blueberry
    eog
    udiskie
    hyprpolkitagent
    clipse
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    sbctl #secure boot key generator
    ((pkgs.sddm-astronaut.override {
      embeddedTheme = "jake_the_dog";
      themeConfig = {
        HeaderTextColor="#0b0c0d";
        DateTextColor="#0b0c0d";
        TimeTextColor="#0b0c0d";

        FormPosition = "left";

        FormBackgroundColor="#6b5491";
        BackgroundColor="#6b5491";
        DimBackgroundColor="#6b5491";
      
        LoginFieldBackgroundColor="#aa9bc9";
        PasswordFieldBackgroundColor="#aa9bc9";
        LoginFieldTextColor="#0b0c0d";
        PasswordFieldTextColor="#0b0c0d";
        UserIconColor="#0b0c0d";
        PasswordIconColor="#0b0c0d";
      
        PlaceholderTextColor="#32302f";
        WarningColor="#b32020";
      
        LoginButtonTextColor="#faf6f0";
        LoginButtonBackgroundColor="#0b0c0d";
        SystemButtonsIconsColor="#0b0c0d";
        SessionButtonTextColor="#0b0c0d";
        VirtualKeyboardButtonTextColor="#0b0c0d";
      
        DropdownTextColor="#0b0c0d";
        DropdownSelectedBackgroundColor="#CCfaf6f0";
        DropdownBackgroundColor="#aa9bc9";

        HighlightTextColor="#faf6f0";
        HighlightBackgroundColor="#aa9bc9";
        HighlightBorderColor="transparent";

        HoverUserIconColor="#FFFFFF";
        HoverPasswordIconColor="#FFFFFF";
        HoverSystemButtonsIconsColor="#FFFFFF";
        HoverSessionButtonTextColor="#FFFFFF";
        HoverVirtualKeyboardButtonTextColor="#FFFFFF";

        BlurMax="48";
        Blur="1.0";

        Background = "Backgrounds/520181.png";
      };
    }).overrideAttrs (oldAttrs: {
      installPhase = oldAttrs.installPhase + ''
        chmod u+w $out/share/sddm/themes/sddm-astronaut-theme/Backgrounds/
        cp ${./wallpaper/nix-d-nord-aurora-crop.png} \
          $out/share/sddm/themes/sddm-astronaut-theme/Backgrounds/520181.png
      '';
    }))

  ];

  # Hyprland
  programs.hyprland = {
    enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  # Browser
  programs.firefox.enable = true;

  # Allow dynamically-linked executables (have to read more/allows Julia Pkgs)
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # Math & Algebra Libraries (Critical for Oscar/Nemo/Hecke)
      gfortran.cc.lib
    ];
  };

  # System fonts
  fonts.packages = with pkgs; [
    nerd-fonts.ubuntu-mono
    nerd-fonts.symbols-only
    material-design-icons
    nerd-fonts.ubuntu
  ]; 
 
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
