{ config, pkgs, ... }:

let
in {
  imports = [ ./modules/default.nix ];

  tnix.home = {
  };

  home.packages = with pkgs; [
  ];

}
