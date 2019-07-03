{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.tnix.home.exwm;
  emacs = import ../../../services/emacs/package.nix { inherit pkgs; };
in {
  options.tnix.home.exwm.enable = mkEnableOption "Enable exwm.";
  config = mkIf cfg.enable {
    xsession.enable = true;
    xsession.windowManager.command = ''
      ${emacs}/bin/emacs --eval '(progn (server-start) (exwm-enable))'
    '';
  };
}
