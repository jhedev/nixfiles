{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.tnix.services.light;
  light = "${pkgs.light}/bin/light";
in {
  options.tnix.services.light.enable = mkEnableOption "Enable light service.";
  config = mkIf cfg.enable {
    programs.light.enable = true;
    services.actkbd = {
      enable = true;
      bindings = [
        {
          keys = [ 225 ];
          events = [ "key" "rep" ];
          command = "${light} -A 0.1";
        }
        {
          keys = [ 224 ];
          events = [ "key" "rep" ];
          command = "${light} -U 0.1";
        }

      ];
    };
    home-manager.users.${config.tnix.services.user.name} = {
      xsession.profileExtra = "sudo ${light} -S 19";
    };
    security.sudo.extraConfig = ''
      %wheel ALL=(ALL:ALL) NOPASSWD: /run/current-system/sw/bin/light
    '';
  };
}
