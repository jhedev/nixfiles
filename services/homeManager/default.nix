{ config, lib, pkgs, ... }:

with lib;

let cfg = config.tnix.services.homeManager;
in {
  options.tnix.services.homeManager.enable =
  mkEnableOption "Enable homeManager.";
  config = mkIf cfg.enable {
    home-manager.users.${config.tnix.services.user.name} =
    import ../../home/home.nix;
  };
}
