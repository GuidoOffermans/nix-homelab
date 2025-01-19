{ config, ... }: {
  networking.firewall = {
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
    allowedTCPPorts = [
      80
      443
      config.services.tailscale.port
    ];
  };
}
