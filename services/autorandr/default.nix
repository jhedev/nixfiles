{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.tnix.services.autorandr;
  autorandr-wrapper = pkgs.writeShellScript "autorandr-wrapper" ''
    #!/usr/bin/env bash
    if [ "$1" == "--fork" ]; then
      echo "$0" | ${pkgs.at}/bin/at now
      exit
    fi
    export DISPLAY=":0"
    export HOME="/home/${config.tnix.services.user.name}"
    export XAUTHORITY="/home/${config.tnix.services.user.name}/.Xauthority"
    ${pkgs.autorandr}/bin/autorandr --change --debug --force
  '';
  nTBP-EDID =
  "00ffffffffffff00061029a00000000032170104a51d1278026fb1a7554c9e250c505400000001010101010101010101010101010101e26800a0a0402e60302036001eb31000001a000000fc00436f6c6f72204c43440a202020000000100000000000000000000000000000000000100000000000000000000000000000004f";
  dell27-EDID =
  "00ffffffffffff0010ac69d04c33433027190103803c2278ee4455a9554d9d260f5054a54b00b300d100714fa9408180778001010101565e00a0a0a029503020350055502100001a000000ff0047483835443539523043334c0a000000fc0044454c4c205532373135480a20000000fd0038561e711e000a20202020202001e1020322f14f1005040302071601141f1213202122230907078301000065030c002000023a801871382d40582c250055502100001e011d8018711c1620582c250055502100009e011d007251d01e206e28550055502100001e8c0ad08a20e02d10103e9600555021000018483f00ca808030401a50130055502100001e00000084";
  iiyama27-EDID =
  "00ffffffffffff0026cd4e66600500000a1d0104b53c22783ef6d5a7544b9e250d5054bfef80714f8140818081c09500b300d1c001014dd000a0f0703e8030203500544f2100001a000000ff0031313636333931303031333736000000fd00184c1fa03c000a202020202020000000fc00504c3237393255480a202020200121020320f15390050403020716011f121314201511065d5e5f2309070783010000023a801871382d40582c4500544f2100001f011d8018711c1620582c2500544f2100009fa76600a0f0701f8030205500544f2100001ff45100a0f070198030203500544f2100001f565e00a0a0a0295030203500544f2100001b000000000059";
in {
  options.tnix.services.autorandr.enable = mkEnableOption "Enable autorandr.";
  config = mkIf cfg.enable {
    services.atd.enable = true;
    services.udev.extraRules = ''
      # Display Change Event
      SUBSYSTEM=="drm", ACTION=="change", RUN+="${autorandr-wrapper} --fork"
    '';
    home-manager.users.${config.tnix.services.user.name} = {
      xsession.profileExtra = "${autorandr-wrapper} --fork";
      programs.autorandr.enable = true;
      programs.autorandr.profiles = {
        "internal" = {
          fingerprint = { eDP1 = "${nTBP-EDID}"; };
          config = {
            eDP1 = {
              enable = true;
              primary = true;
              mode = "2560x1600";
              rate = "59.97";
              position = "0x0";
            };
            DP2.enable = false;
            HDMI2.enable = false;
          };
        };
        "dell27-dual" = {
          fingerprint = {
            eDP1 = "${nTBP-EDID}";
            HDMI2 = "${dell27-EDID}";
          };
          config = {
            eDP1 = {
              enable = true;
              mode = "2560x1600";
              rate = "59.97";
              position = "0x0";
            };
            DP2.enable = false;
            HDMI2 = {
              enable = true;
              primary = true;
              mode = "2560x1440";
              rate = "59.95";
              position = "2560x0";
            };
          };
        };
        "dell27-external" = {
          fingerprint = {
            eDP1 = "${nTBP-EDID}";
            HDMI2 = "${dell27-EDID}";
          };
          config = {
            eDP1.enable = false;
            DP2.enable = false;
            HDMI2 = {
              enable = true;
              primary = true;
              mode = "2560x1440";
              rate = "59.95";
              position = "0x0";
            };
          };
        };
        "iiyama27-dual" = {
          fingerprint = {
            eDP1 = "${nTBP-EDID}";
            DP2 = "${iiyama27-EDID}";
          };
          config = {
            eDP1 = {
              enable = true;
              mode = "2560x1600";
              rate = "59.97";
              position = "0x0";
            };
            DP2 = {
              enable = true;
              primary = true;
              mode = "3840x2160";
              # rate = "59.95";
              position = "2560x0";
            };
            HDMI2.enable = false;
          };
        };
        "iiyama27-external" = {
          fingerprint = {
            eDP1 = "${nTBP-EDID}";
            DP2 = "${iiyama27-EDID}";
          };
          config = {
            eDP1.enable = false;
            DP2 = {
              enable = true;
              primary = true;
              mode = "3840x2160";
              rate = "60";
              position = "2560x0";
            };
            HDMI2.enable = false;
          };
        };
      };
    };
  };
}
