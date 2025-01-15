{ config, ... }:
{
  sops.secrets = {
    # "cloudflare-api-email" = { };
    "cloudflare-api-token" = { };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "dev@guidooffermans.com";

    certs."pothos.cloud" = {
      group = config.services.caddy.group;
      domain = "pothos.cloud";
      extraDomainNames = [ "*.pothos.cloud" ];
      dnsProvider = "cloudflare";
      dnsResolver = "1.1.1.1:53";
      dnsPropagationCheck = true;
      # inspo: https://go-acme.github.io/lego/dns/cloudflare/
      credentialFiles = {
        "CLOUDFLARE_DNS_API_TOKEN_FILE" = config.sops.secrets."cloudflare-api-token".path;
      };
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  services.caddy = {
    enable = true;
    virtualHosts."localhost".extraConfig = ''
      respond "OK"
    '';
  };

  environment.persistence."/nix/persist" = {
    directories = [
      "/var/lib/acme"
    ];
  };
}
