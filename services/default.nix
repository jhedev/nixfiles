{ lib, ... }:

with lib; {
  imports = [
    ./autorandr/default.nix
    ./common/default.nix
    ./emacs/default.nix
    ./fonts/default.nix
    ./homeManager/default.nix
    ./light/default.nix
    ./programs/default.nix
    ./tty/default.nix
    ./users/default.nix
    ./sound/default.nix
    ./virtualbox/default.nix
    ./wireguard/default.nix
    ./x11/default.nix
  ];
}
