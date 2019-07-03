{ config, lib, pkgs, ... }:

with lib;

let cfg = config.tnix.home.vim;
in {
  options.tnix.home.vim.enable = mkEnableOption "Enable vim.";
  config = mkIf cfg.enable {
    programs.vim = {
      enable = true;
      plugins = [ "sensible" "commentary" ];
      extraConfig = ''
        set backupdir=/tmp//
        set directory=/tmp//
        set undodir=/tmp//
      '';
    };
  };
}
