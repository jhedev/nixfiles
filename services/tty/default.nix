{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.tnix.services.tty;
in {
  options.tnix.services.tty.enable = mkEnableOption "Enable TTY settings.";
  config = mkIf cfg.enable {
    # Select internationalisation properties.
    i18n = {
      # FIXME: Unicode
      #consoleFont = "iso01-12x22";
      consoleFont = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
      # zenburn-ish
      consoleColors = [
        "4d4d4d"
        "705050"
        "60b48a"
        "f0dfaf"
        "506070"
        "dc8cc3"
        "8cd0d3"
        "dcdccc"
        "709080"
        "dca3a3"
        "c3bf9f"
        "e0cf9f"
        "94bff3"
        "ec93d3"
        "93e0e3"
        "ffffff"
      ];
      consoleKeyMap = lib.mkDefault "neo";
      consoleUseXkbConfig = false;
      defaultLocale = "en_US.UTF-8";
    };
    programs.zsh.enable = true;
  };
}
