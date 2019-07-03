{ config, lib, pkgs, ... }:

with lib;

let cfg = config.tnix.home.urxvt;
in {
  options.tnix.home.urxvt.enable = mkEnableOption "Enable urxvt.";
  config = mkIf cfg.enable {
    programs.urxvt = {
      enable = true;
      fonts = [ "xft:Dejavu Sans Mono for Powerline:size=12" ];
      extraConfig = {
        # zenburn theme
        termName = "rxvt-256color";
        xftAntialias = "true";
        background = "#3f3f3f";
        foreground = "#dcdccc";
        cursorColor = "#aaaaaa";
        colorUL = "#669090";
        underlineColor = "#dfaf8f";
        color0 = "#3f3f3f";
        color1 = "#cc9393";
        color2 = "#7f9f7f";
        color3 = "#d0bf8f";
        color4 = "#6ca0a3";
        color5 = "#dc8cc3";
        color6 = "#93e0e3";
        color7 = "#dcdccc";
        color8 = "#000000";
        color9 = "#dca3a3";
        color10 = "#bfebbf";
        color11 = "#f0dfaf";
        color12 = "#8cd0d3";
        color13 = "#dc8cc3";
        color14 = "#93e0e3";
        color15 = "#ffffff";
      };
    };
  };
}
