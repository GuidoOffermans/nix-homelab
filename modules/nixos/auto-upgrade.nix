{
  system.autoUpgrade = {
    enable = false;
    dates = "*-*-* 07:00:00";
    randomizedDelaySec = "1h";
    flake = "github:GuidoOffermans/nix-homelab";
  };
}
