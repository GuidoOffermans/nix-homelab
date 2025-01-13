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
    ./../../modules/nixos/remote-unlock.nix
    ./../../modules/nixos/auto-update.nix

    ./../../services/tailscale.nix
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
