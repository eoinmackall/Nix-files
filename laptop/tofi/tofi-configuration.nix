{
  programs.tofi = {
    enable = true; # Ensure tofi itself is enabled
    settings = {
      # General appearance and fonts
      font = "UbuntuMono Nerd Font Mono";
      font-size = 20;
      background-color = "#10121c";
      text-color = "#cad3f5";
      width = 500;
      height = 400;
      border-width = 3;
      border-color = "#7673bd";
      outline-width = 0;
      outline-color = "#000000";
      corner-radius = 0;

      # Layout and positioning
      prompt-text = "Run: ";
      horizontal = false;
      anchor = "center";
      num-results = 0; # 0 means fit as many as possible

      # Theming specific elements
      selection-color = "#e64553";
      selection-match-color = "#00000000"; 
      prompt-background = "#10121c";
      placeholder-color = "#FFFFFFA8";
      text-cursor-style = "block";
      text-cursor = true;

      # Behavior options
      history = true;
      require-match = true;
      auto-accept-single = false;
      drun-launch = true;
      # Add other translated options here...
    };
  };
}
