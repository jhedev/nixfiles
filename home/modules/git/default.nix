{ config, lib, pkgs, ... }:

with lib;

let cfg = config.tnix.home.git;
in {
  options.tnix.home.git = {
    enable = mkEnableOption "Enable git.";
    userName = mkOption {
      type = with types; uniq string;
      description = "Git userName.";
    };
    userEmail = mkOption {
      type = with types; uniq string;
      description = "Git userEmail.";
    };
  };
  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = cfg.userName;
      userEmail = cfg.userEmail;
      ignores = [
        "*#"
        "*.swp"
        "*~"
        # TODO: override this locally
        "project.org"
      ];
    };

  };
}
