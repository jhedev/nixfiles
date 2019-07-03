{ lib, ... }:

with lib; {
  imports = [
    ./common/default.nix
    ./emacs/default.nix
  ];
}
