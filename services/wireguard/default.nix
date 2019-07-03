{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.tnix.services.wireguard;
  secrets = import ../../secrets.nix { };
in {
  options.tnix.services.wireguard.enable = mkEnableOption "Enable wireguard.";
  config = mkIf cfg.enable {
    networking.wg-quick.interfaces = {
      wg0 = {
        address = [ "10.99.0.233/32" ];
        dns = [ "193.138.218.74" ];
        privateKey = secrets.wireguard.mullvad.privateKey;
        peers = [{
          allowedIPs = [ "0.0.0.0/0" ];
          endpoint = "185.216.33.114:51820";
          publicKey = "IF4ROzAOkRKdz+Hy+TWS1LTOZPGaLsm9PW5EN5AEOkc=";
        }];
      };
    };
  };
}
