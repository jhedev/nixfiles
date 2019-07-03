{ lib, ... }:

with lib; {
  imports = [
    ./common/default.nix
    ./emacs/default.nix
    ./exwm/default.nix
    ./git/default.nix
    ./urxvt/default.nix
  ];
}
