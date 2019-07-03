{ lib, ... }:

with lib; {
  imports = [
    ./autorandr/default.nix
    ./common/default.nix
    ./emacs/default.nix
    ./fonts/default.nix
    ./homeManager/default.nix
    ./programs/default.nix
    ./tty/default.nix
    ./users/default.nix
    ./sound/default.nix
  ];
}
