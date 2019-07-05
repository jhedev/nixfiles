{ config, lib, pkgs, ... }:

with lib;

let
  meta = import ../../hosts/current/meta.nix;
  cfg = config.tnix.services.common;
in {
  options.tnix.services.common.enable = mkEnableOption "Enable common defaults.";
  options.tnix.services.common.offline = mkEnableOption "Enable offline compatability.";
  config = mkIf cfg.enable {
    boot.cleanTmpDir = true;

    time.timeZone = "Europe/Amsterdam";

    nix = {
      maxJobs = 4;
      autoOptimiseStore = true;
      extraOptions = mkIf cfg.offline ''
        keep-outputs = true
        keep-derivations = true
      '';
    };

    services.nixosManual = {
      showManual = true;
      ttyNumber = 5;
    };

    services.physlock = {
      enable = true;
      allowAnyUser = true;
    };

    nixpkgs.config.allowUnfree = true;

    # build config to /etc/current-nixos-config/
    environment.etc.current-nixos-config.source = ../..;

    virtualisation.virtualbox.guest.enable = meta.vm_guest;
  };
}
