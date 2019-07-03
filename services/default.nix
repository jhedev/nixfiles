{ lib, ... }:

with lib; {
  imports = [
    ./autorandr/default.nix
    ./common/default.nix
    ./emacs/default.nix
  ];
}
