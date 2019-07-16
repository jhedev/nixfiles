{ config, lib, pkgs, ... }:

with lib;

let cfg = config.tnix.services.virtualbox;
in {
  options.tnix.services.virtualbox.enable = mkEnableOption "Enable Virtualbox.";
  config = mkIf cfg.enable {
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members =
    [ "${config.tnix.services.user.name}" ];
  };
}
