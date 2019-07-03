{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.tnix.services.emacs;
in {
  options.tnix.services.emacs.enable = mkEnableOption "Enable Emacs.";
  config = mkIf cfg.enable {
    services.emacs = {
      install = true;
      defaultEditor = true;
      package = import ./package.nix { inherit pkgs; };
    };
  };
}
