{ lib, ... }:

with lib; {
  imports = [
    ./autorandr/default.nix
    ./common/default.nix
    ./emacs/default.nix
    ./fonts/default.nix
    ./homeManager/default.nix
    ./programs/default.nix
    ./users/default.nix
  ];
}
