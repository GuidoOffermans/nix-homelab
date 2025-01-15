{ config, ... }: {
  services.audiobookshelf = {
    enable = true;
    # listenPort = 13378;
  };

  services.caddy.virtualHosts."audiobookshelf.pothos.cloud" = {
    extraConfig = ''
      reverse_proxy 127.0.0.1:13378
    '';
  };
}
