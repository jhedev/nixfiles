{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.tnix.home.emacs;
  emacs = import ./../../../services/emacs/package.nix { inherit pkgs; };
  org-build = { config, init }:
  let
    env = { buildInputs = [ emacs ]; };
    script = { config, init }: ''
      ln -s "${config}" ./config.org
      ln -s "${init}" ./init.el
      emacs --batch -Q --eval '
        (let ((tmacs-file-config-src (expand-file-name "config.org"))
              (tmacs-file-config-dist (expand-file-name "config.el"))
              (tmacs--build-run nil)
              (tmacs--build-force t))
          (load-file (expand-file-name "init.el")))'
      emacs --batch -Q --eval '
        (let ((tmacs-file-config-dist (expand-file-name "config.el")))
          (load-file (expand-file-name "init.el")))'
      cp ./config.el $out
    '';
  in pkgs.runCommand "org-build" env (script {
    inherit config;
    inherit init;
  });
in {
  options.tnix.home.emacs.enable = mkEnableOption "Enable Emacs.";
  config = mkIf cfg.enable {

    home.file.".emacs" = { source = ./init.el; };
    home.file.".emacs.d/config.el".source = (org-build {
      config = ./config.org;
      init = ./init.el;
    });
  };
}
