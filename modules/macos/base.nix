{ pkgs, ... }:
{
  nix = {
    package = pkgs.nix;
    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 0;
        Minute = 0;
      };
      options = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
    };
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [
        "pothos"
        "guidooffermans"
        "root"
        "@admin"
      ];
    };
    # Distributed builds
    distributedBuilds = true;
    buildMachines = [
      {
        hostName = "eu.nixbuild.net";
        system = "x86_64-linux";
        maxJobs = 100;
        supportedFeatures = [
          "benchmark"
          "big-parallel"
        ];
      }
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    neovim
    sops
    statix
    nixos-rebuild
  ];

  programs.zsh.enable = true;
  security.pam.enableSudoTouchIdAuth = true;

  programs = {
    # SSH configuration
    ssh = {
      knownHosts = {
        nixbuild = {
          hostNames = [ "eu.nixbuild.net" ];
          publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPIQCZc54poJ8vqawd8TraNryQeJnvH1eLpIDgbiqymM";
        };
      };
      extraConfig = ''
        Host eu.nixbuild.net
        PubkeyAcceptedKeyTypes ssh-ed25519
        ServerAliveInterval 60
        IPQoS throughput
        IdentityFile /Users/guidooffermans/.ssh/pothos-services
      '';
    };
  };

  services = {
    nix-daemon.enable = true;
    tailscale.enable = true;
  };

  users.users.guidooffermans.home = "/Users/guidooffermans";

  system = {
    stateVersion = 5;
  };
}
