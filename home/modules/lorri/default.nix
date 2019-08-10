{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.tnix.home.lorri;
  lorri = import (fetchTarball {
    url = "https://github.com/target/lorri/archive/rolling-release.tar.gz";
  }) { };
  path = with pkgs; lib.makeSearchPath "bin" [ nix gnutar git mercurial ];
in {
  options.tnix.home.lorri.enable = mkEnableOption "Enable lorri.";
  config = mkIf cfg.enable {
    home.packages = [ lorri ];

    systemd.user.sockets.lorri = {
      Unit = { Description = "lorri build daemon"; };
      Socket = { ListenStream = "%t/lorri/daemon.socket"; };
      Install = { WantedBy = [ "sockets.target" ]; };
    };

    systemd.user.services.lorri = {
      Unit = {
        Description = "lorri build daemon";
        Documentation = "https://github.com/target/lorri";
        ConditionUser = "!@system";
        Requires = "lorri.socket";
        After = "lorri.socket";
        RefuseManualStart = true;
      };

      Service = {
        ExecStart = "${lorri}/bin/lorri daemon";
        PrivateTmp = true;
        ProtectSystem = "strict";
        WorkingDirectory = "%h";
        Restart = "on-failure";
        Environment = "PATH=${path} RUST_BACKTRACE=1";
      };
    };
  };
}
