{ config, ... }:
{
  sops.secrets."tailscale-authkey" = { };

  services.tailscale = {
    enable = true;
    openFirewall = true;
    authKeyFile = config.sops.secrets."tailscale-authkey".path;
    useRoutingFeatures = "server";
    extraUpFlags = [
      "--advertise-routes=10.10.10.0/24"
    ];
  };

  environment.persistence."/nix/persist" = {
    directories = [
      "/var/lib/tailscale"
    ];
  };
}
