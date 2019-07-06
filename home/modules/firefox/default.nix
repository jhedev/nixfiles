{ config, lib, pkgs, ... }:

with lib;

let cfg = config.tnix.home.firefox;
in {
  options.tnix.home.firefox.enable = mkEnableOption "Enable Firefox.";
  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        dark-night-mode
        https-everywhere
        greasemonkey
        link-cleaner
        privacy-badger
        reddit-enhancement-suite
        stylus
        ublock-origin
      ];
      profiles.tjdev = {
        name = "";
        settings = {
          "browser.privatebrowsing.autostart" = true;
          "extensions.allowPrivateBrowsingByDefault" = true;
          "browser.startup.homepage" =
          "https://start.duckduckgo.com/?kak=-1&kal=-1&kao=-1&kaq=-1&kae=d&kp=-2&kz=1&kav=1&kaj=m&kam=google-maps&kax=-1&kap=-1&kau=-1&kt=p&ks=n&km=l&kw=n&kh=1";
          "lightweightThemes.selectedThemeID" =
          "firefox-compact-dark@mozilla.org";
          "devtools.theme" = "dark";
        };
      };
    };
  };
}
