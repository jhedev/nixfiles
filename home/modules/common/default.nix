{ config, lib, pkgs, ... }:

with lib;

let cfg = config.tnix.home.common;
in {
  options.tnix.home.common.enable = mkEnableOption "Enable common features.";
  config = mkIf cfg.enable {
    programs.home-manager = { enable = true; };

    home.keyboard = {
      layout = "de";
      variant = "neo";
    };

    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.packageOverrides = pkgs: {
      nur = import (builtins.fetchTarball
      "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
    };
  };
}
