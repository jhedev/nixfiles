{ config, pkgs, ... }:

let
  nixfmt = import (pkgs.fetchFromGitHub {
    owner = "serokell";
    repo = "nixfmt";
    rev = "dbed3c31c777899f0273cb6584486028cd0836d8";
    sha256 = "0gsj5ywkncl8rahc8lcij7pw9v9214lk23wspirlva8hwyxl279q";
  }) { };

in {
  imports = [ ./modules/default.nix ];

  tnix.home = {
    common.enable = true;
    emacs.enable = true;
    exwm.enable = true;
  };

  home.packages = with pkgs; [
    nixfmt
  ];

}
