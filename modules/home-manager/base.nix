{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./_packages.nix
    # ./_zsh.nix
  ];

  home = {
    username = lib.mkMerge [
      (lib.mkIf pkgs.stdenv.isLinux "pothos")
      (lib.mkIf pkgs.stdenv.isDarwin "guidooffermans")
    ];
    homeDirectory = lib.mkMerge [
      (lib.mkIf pkgs.stdenv.isLinux "/home/pothos")
      (lib.mkIf pkgs.stdenv.isDarwin "/Users/guidooffermans")
    ];
    stateVersion = "23.11";
    sessionVariables = lib.mkIf pkgs.stdenv.isDarwin {
      SOPS_AGE_KEY_FILE = "$HOME/.config/sops/age/keys.txt";
    };
  };

  programs = {
    git = {
      enable = true;
    };
    # helix = {
    #   enable = true;
    #   defaultEditor = true;
    #   settings = {
    #     theme = "dark_high_contrast";
    #   };
    # };
    # fzf = {
    #   enable = true;
    #   enableZshIntegration = true;
    # };
    # zellij = {
    #   enable = true;
    #   settings = {
    #     theme = "dracula";
    #   };
    # };
    # tealdeer = {
    #   enable = true;
    #   settings.updates.auto_update = true;
    # };
    # lsd = {
    #   enable = true;
    #   enableAliases = true;
    # };
    # direnv = {
    #   enable = true;
    #   enableZshIntegration = true;
    #   nix-direnv.enable = true;
    # };
    # fastfetch.enable = true;
  };

  # Nicely reload system units when changing configs
  # Self-note: nix-darwin seems to luckily ignore this setting
  systemd.user.startServices = "sd-switch";
}
