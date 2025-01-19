{
  inputs,
  outputs,
  ...
}:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    inputs.home-manager.nixosModules.home-manager

    ./hardware-configuration.nix

    ./../../modules/nixos/base.nix
    ./../../modules/nixos/auto-update.nix

    ./../../services/network.nix

    ./../../services/tailscale.nix
    # ./../../services/caddy.nix
    # ./../../services/audiobookshelf.nix

  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      pothos = {
        imports = [
          ./../../modules/home-manager/base.nix
        ];
      };
    };
  };

  networking.hostName = "pothos1";
}
