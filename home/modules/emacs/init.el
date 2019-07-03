(setq gc-cons-threshold most-positive-fixnum)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)

(setq load-prefer-newer t)

(eval-when-compile
  (require 'use-package)
  (package-initialize))

;; We install all packages with Nix
(setq use-package-ensure-function 'require)

(defconst tmacs-debug nil
  "Enable debug features.")

(defconst tmacs-file-nixos-root
  "/etc/nixos"
  "Path to nixos root.")

(defconst tmacs-file-nixos-home
  "/etc/nixos/home"
  "Path to nixos home directory.")

(defconst tmacs-file-nixos-emacs
  "/etc/nixos/home/modules/emacs"
  "Path to Emacs directory.")

(defconst tmacs-file-init
  (expand-file-name "init.el" tmacs-file-nixos-emacs)
  "Path to init.el.")

(defvar tmacs-file-config-src
  (expand-file-name "config.org" tmacs-file-nixos-emacs)
  "Path to config.org.")

(defvar tmacs-file-config-dist
  (if tmacs-debug "/tmp/config.el"
    (expand-file-name "config.el" user-emacs-directory))
  "Path to config.el.")

(defvar tmacs--build-force nil
  "Force build 'tmacs-file-config-src to 'tmacs-file-config-dist.")

(defvar tmacs--build-run t
  "Load 'tmacs-file-config-dist after build.")

(setq vc-follow-symlinks t)

;; FIXME:
;; (when tmacs-debug (toggle-debug-on-error))

(when (or tmacs--build-force
	  (not (file-exists-p tmacs-file-config-dist)))
  (message (format "Build %s -> %s..."
		   tmacs-file-config-src
		   tmacs-file-config-dist))
  (require 'org)
  (let ((body-list))
    (org-babel-map-src-blocks tmacs-file-config-src
      (when (and body
		 (string-equal (downcase lang) "emacs-lisp"))
	(push body body-list)))
    (let ((parens-error (with-temp-file tmacs-file-config-dist
			  (insert (format ";; %s\n;; %s\n;; %s\n"
					  "Automatically generated, do not edit."
					  (format "   src: %s" tmacs-file-config-src)
					  (format "  date: %s" (current-time-string))))
			  (apply 'insert (reverse body-list))
			  (condition-case nil
			      (check-parens)
			    (error
			     (line-number-at-pos (point)))))))
      (if parens-error
	  (error "error: imbalanced parens in line %s" parens-error)
	(message "Success")))))

(when tmacs--build-run
  (load-file tmacs-file-config-dist))

(setq gc-cons-threshold (* 1024 1024))
