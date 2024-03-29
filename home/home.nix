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
    direnv.enable = true;
    emacs.enable = true;
    exwm.enable = true;
    firefox.enable = true;
    git.enable = true;
    git.userName = "tobjaw";
    git.userEmail = "tobjaw@gmail.com";
    lorri.enable = true;
    urxvt.enable = true;
    vim.enable = true;
    zsh.enable = true;
  };

  home.packages = with pkgs; [ awscli chromium jq htop nixfmt ripgrep unzip ];

}
