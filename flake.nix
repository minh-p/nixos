{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      # Optional, by default this flake follows nixpkgs-unstable.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/default/configuration.nix
        inputs.home-manager.nixosModules.default
	inputs.sddm-sugar-candy-nix.nixosModules.default
	{
	  nixpkgs = {
	    overlays = [
	      inputs.sddm-sugar-candy-nix.overlays.default
	    ];
	  };
	}
      ];
    };
  };
}
