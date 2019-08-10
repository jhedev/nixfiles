{ lib, ... }:

with lib; {
  imports = [
    ./common/default.nix
    ./direnv/default.nix
    ./emacs/default.nix
    ./exwm/default.nix
    ./firefox/default.nix
    ./git/default.nix
    ./lorri/default.nix
    ./urxvt/default.nix
    ./vim/default.nix
    ./zsh/default.nix
  ];
}
