{
  config,
  ...
}:
{
  boot.kernelParams = [ "ip=dhcp" ];
  boot.initrd.network = {
    enable = true;
    ssh = {
      enable = true;
      shell = "/bin/cryptsetup-askpass";
      authorizedKeys = config.users.users.pothos.openssh.authorizedKeys.keys;
      hostKeys = [ "/nix/secret/initrd/ssh_host_ed25519_key" ];
    };
  };
}
