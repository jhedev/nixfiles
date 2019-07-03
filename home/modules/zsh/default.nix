{ config, lib, pkgs, ... }:

with lib;

let cfg = config.tnix.home.zsh;
in {
  options.tnix.home.zsh.enable = mkEnableOption "Enable zsh.";
  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      # plugins = [];
      shellAliases = {
        nsh = "nix-shell";
        gs = "git status";

        tmacs-bootstrap = ''
          vim -O /etc/nixos/home/emacs/.emacs /etc/nixos/home/emacs/config.org && \
          emacs -Q --load /etc/nixos/home/emacs/.emacs
        '';

      };
    };
  };
}
