{
  imports = [
    ./_packages.nix
  ];

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPHf99Qb7gCWSgEqb9bDWF76pwP3q7+1rUhd0RZEAk5T"
    ];
  };

  programs.bash.shellAliases = {
    install = "sudo bash -c '$(curl -fsSL https://raw.githubusercontent.com/eh8/chenglab/main/install.sh)'";
  };

  security.sudo.wheelNeedsPassword = false;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services.openssh = {
    enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
