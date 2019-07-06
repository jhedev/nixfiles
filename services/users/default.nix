{ config, lib, pkgs, ... }:

with lib;

let cfg = config.tnix.services.user;
in {
  options.tnix.services.user.enable = mkEnableOption "Enable user.";
  options.tnix.services.user.name = mkOption {
    type = with types; uniq string;
    description = "Unix user name.";
  };
  config = mkIf cfg.enable {
    security.sudo.enable = true;
    security.sudo.extraConfig = ''
      %wheel ALL=(ALL:ALL) NOPASSWD: /run/current-system/sw/bin/nix-shell
      %wheel ALL=(ALL:ALL) NOPASSWD: /run/current-system/sw/bin/nix-channel
      %wheel ALL=(ALL:ALL) NOPASSWD: /run/current-system/sw/bin/nixos-rebuild
      %wheel ALL=(ALL:ALL) NOPASSWD: /run/current-system/sw/bin/nix-env
    '';

    users.groups.plugdev = { };

    users.users.root = { shell = pkgs.zsh; };

    users.users.${cfg.name} = {
      isNormalUser = true;
      extraGroups = [ "wheel" "dialout" "plugdev" "systemd-journal" ];
      shell = pkgs.zsh;
    };
  };
}
