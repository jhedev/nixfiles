{ lib, ... }:

with lib; {
  imports = [
    ./autorandr/default.nix
  ];
}
