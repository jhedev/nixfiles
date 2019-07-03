{ config, lib, pkgs, ... }:

with lib;

let cfg = config.tnix.services.programs;
in {
  options.tnix.services.programs.enable =
  mkEnableOption "Enable common programs.";
  config = mkIf cfg.enable {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [ xorg.xkbcomp libinput-gestures ];
  };
}
