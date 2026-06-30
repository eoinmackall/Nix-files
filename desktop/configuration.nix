{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Hardware
  hardware.bluetooth.enable = true;
  hardware.system76.enableAll = true;
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
    nvidiaSettings = true;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Nix-features
  nix.settings.experimental-features = [ "nix-command" "flakes"];
  
  # Allow unfree packages (needed for Cuda)
  nixpkgs.config.allowUnfree = true;

  # Networking
  networking.hostName = "nixos-desktop";
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

  # Nvidia drivers
  services.xserver.videoDrivers = [ "nvidia" ];

  # Ollama server and local chat interface 
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda; 
  };

  services.open-webui = {
    enable = true;
    port = 8080;
  }; 

  # Enable Flatpak
  services.flatpak.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Login greeter/display manager
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
    extraPackages = with pkgs; [
      kdePackages.qtmultimedia
    ];
    theme = "sddm-astronaut-theme";
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enables d-bus
  services.dbus.enable = true;

  # Enables automatic disk mounting
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # To recognize my Garmin watch
  services.udev.extraRules = ''
    # Garmin vivoactive 5 - Force MTP recognition
    SUBSYSTEM=="usb", ATTR{idVendor}=="091e", ATTR{idProduct}=="514a", ENV{ID_MTP_DEVICE}="1", ENV{ID_MEDIA_PLAYER}="1", MODE="0666", GROUP="users"
    '';
 
  # User account  
  users.users.eoinm = {
    isNormalUser = true;
    description = "Eoin Mackall";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
 
  # System packages
  environment.systemPackages = with pkgs; [
    wget
    neovim
    git
    kitty
    wl-clipboard
    grim
    slurp
    clipse
    yazi
    pavucontrol
    hyprcursor
    hyprlock
    hypridle
    hyprsunset
    brightnessctl
    udiskie
    rose-pine-hyprcursor
    hyprpolkitagent
    thunderbird
    libmtp
    jmtpfs
    (llama-cpp.override { cudaSupport = true; }) 
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ((pkgs.sddm-astronaut.override {
      embeddedTheme = "jake_the_dog";
      themeConfig = {
        HeaderTextColor="#000000";
        DateTextColor="#000000";
        TimeTextColor="#000000";

        FormBackgroundColor="#18a7d6";
        BackgroundColor="#18a7d6";
        DimBackgroundColor="#18a7d6";
      
        LoginFieldBackgroundColor="#9bbec9";
        PasswordFieldBackgroundColor="#9bbec9";
        LoginFieldTextColor="#000000";
        PasswordFieldTextColor="#000000";
        UserIconColor="#000000";
        PasswordIconColor="#000000";
      
        PlaceholderTextColor="#32302f";
        WarningColor="#b32020";
      
        LoginButtonTextColor="#faf6f0";
        LoginButtonBackgroundColor="#000000";
        SystemButtonsIconsColor="#000000";
        SessionButtonTextColor="#000000";
        VirtualKeyboardButtonTextColor="#000000";
      
        DropdownTextColor="#000000";
        DropdownSelectedBackgroundColor="#CCfaf6f0";
        DropdownBackgroundColor="#9bbec9";

        HighlightTextColor="#faf6f0";
        HighlightBackgroundColor="#9bbec9";
        HighlightBorderColor="transparent";

        HoverUserIconColor="#FFFFFF";
        HoverPasswordIconColor="#FFFFFF";
        HoverSystemButtonsIconsColor="#FFFFFF";
        HoverSessionButtonTextColor="#FFFFFF";
        HoverVirtualKeyboardButtonTextColor="#FFFFFF";

        BlurMax="48";
        Blur="1.0";

        Background = "Backgrounds/520180.jpg";
      };
    }).overrideAttrs (oldAttrs: {
      installPhase = oldAttrs.installPhase + ''
        chmod u+w $out/share/sddm/themes/sddm-astronaut-theme/Backgrounds/
        cp ${./wallpaper/520180.jpg} \
          $out/share/sddm/themes/sddm-astronaut-theme/Backgrounds/520180.jpg
      '';
    }))
  ];

  # Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  # Browswer
  programs.firefox.enable = true;

  # Allow dynamically-linked executables (allows Julia Pkgs)
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # Math & Algebra Libraries (Critical for Oscar/Nemo/Hecke)
      gfortran.cc.lib
    ];
  };

  # System fonts
  fonts.packages = with pkgs; [
    nerd-fonts.ubuntu
    nerd-fonts.ubuntu-mono
    nerd-fonts.symbols-only
    material-design-icons
  ]; 
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
