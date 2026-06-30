{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows="nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

    # Maybe add nixos-hardware to this in the future, if they get the
    # screen to be functional, etc.
  outputs = inputs@{nixpkgs, home-manager, lanzaboote, ...}: {      
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
          modules = [
            ./configuration.nix
	    #nixos-hardware.nixosModules.microsoft-surface-laptop-amd
	    home-manager.nixosModules.home-manager
            {
	      home-manager.useGlobalPkgs = true;
	      home-manager.useUserPackages = true;
	      home-manager.backupFileExtension = "hm-back";
       	      home-manager.users.eoinm = {
	        imports = [
                  ./home.nix
                  inputs.noctalia.homeModules.default
		];
	      };
	     }
	     lanzaboote.nixosModules.lanzaboote
	     ({ pkgs, lib, ...}: {
	       environment.systemPackages = [
               pkgs.sbctl
               ];
	       boot.loader.systemd-boot.enable = lib.mkForce false;
               boot.lanzaboote = {
                 enable = true;
                 pkiBundle = "/var/lib/sbctl";
	       };
            })
           ];
         };
       };
     };
}
