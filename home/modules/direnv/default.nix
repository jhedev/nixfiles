{ config, lib, pkgs, ... }:

with lib;

let cfg = config.tnix.home.direnv;
in {
  options.tnix.home.direnv.enable = mkEnableOption "Enable direnv.";
  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
