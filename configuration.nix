{ ... }:

{
  imports = [
    ./hosts/current/hardware-configuration.nix
    ./hosts/current/default.nix
  ];
  system.stateVersion = "19.03";
}
