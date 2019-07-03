{ config, pkgs, ... }:

let
in {
  imports = [ ./modules/default.nix ];

  tnix.home = {
    common.enable = true;
  };

  home.packages = with pkgs; [
  ];

}
