{ config, lib, pkgs, ... }:
with lib;

let cfg = config.tnix.services.sound;
in {
  options.tnix.services.sound.enable = mkEnableOption "Enable sound.";
  config = mkIf cfg.enable {
    sound.enable = true;
    environment.systemPackages = with pkgs; [ procps volnoti ];
    systemd.user.services.volnoti = {
      description = "Volume Notifications";
      after = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.volnoti}/bin/volnoti -t 1 -n -v";
        ExecStop = "${pkgs.procps}/bin/pkill volnoti";
      };
    };
  };
}
