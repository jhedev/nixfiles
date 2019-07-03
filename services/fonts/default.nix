{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.tnix.services.fonts;
in
{
  options.tnix.services.fonts.enable = mkEnableOption "Enable fonts.";
  config = mkIf cfg.enable {
    fonts.enableFontDir = true;
    fonts.enableGhostscriptFonts = true;
    fonts.fonts = with pkgs; [
      corefonts
      dejavu_fonts
      emacs-all-the-icons-fonts
      fira
      fira-code
      fira-mono
      google-fonts
      hack-font
      ibm-plex
      office-code-pro
      powerline-fonts
      roboto
      roboto-mono
      source-code-pro
      source-sans-pro
      terminus
    ];

  };
}
