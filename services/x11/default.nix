{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.tnix.services.x11;
  emacs = import ../emacs/package.nix { inherit pkgs; };
in {
  options.tnix.services.x11.enable = mkEnableOption "Enable x11.";
  options.tnix.services.x11.autorun = mkEnableOption "Boot into GUI.";
  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      autorun = cfg.autorun;

      dpi = 144;
      layout = "de";
      xkbVariant = "neo";
      autoRepeatDelay = 200;
      autoRepeatInterval = 25;
      exportConfiguration = true;

      displayManager.sessionCommands = ''
        ${pkgs.xorg.xhost}/bin/xhost +SI:localuser:$USER
      '';
    };
  };
}
