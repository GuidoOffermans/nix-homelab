{
  description = "Pothos lab";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

      darwinConfigurations = {
        macm2 = nix-darwin.lib.darwinSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./machines/macm2/configuration.nix ];
        };
      };

      nixosConfigurations = {
        pothos1 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./machines/pothos1/configuration.nix ];
          specialArgs = { inherit inputs; };
        };

        pothos2 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./machines/pothos2/configuration.nix ];
        };
      };
    };
}
