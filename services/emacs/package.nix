{ pkgs }:

with pkgs;
with emacsPackagesNg;
let
  doom-modeline = melpaBuild {
    pname = "doom-modeline";
    ename = "doom-modeline";
    version = "2.3.5";
    recipe = builtins.toFile "recipe" ''
      (doom-modeline :fetcher github
                     :repo "seagle0128/doom-modeline")
    '';
    packageRequires = [ all-the-icons shrink-path dash ];
    src = fetchFromGitHub {
      owner = "seagle0128";
      repo = "doom-modeline";
      rev = "4befbbbdcef661438babd8ef384c092a71fbd3d0";
      sha256 = "052c6kcckghfmvf2c0z7b5l7ggyag2a0csjax8dcqw2773ffw5zm";
    };
  };
  emacsWithPackages = (emacsPackagesNgGen emacs).emacsWithPackages;
  exwm = melpaBuild {
    pname = "exwm";
    ename = "exwm";
    version = "0.22";
    recipe = builtins.toFile "recipe" ''
      (exwm :fetcher github
            :repo "ch11ng/exwm")
    '';
    packageRequires = [ xelb ];
    src = fetchFromGitHub {
      owner = "ch11ng";
      repo = "exwm";
      rev = "b1f74203bee715774e5f22a26edd941464f5e236";
      sha256 = "11wzgfhxgvb1s18ihmlga7m5wshg0rdrkaq30rknix5irl8zw64w";
    };
  };
  exwm-edit = melpaBuild {
    pname = "exwm-edit";
    ename = "exwm-edit";
    version = "0.0.1";
    recipe = builtins.toFile "recipe" ''
      (exwm-edit :fetcher github
                 :repo "walseb/exwm-edit")
    '';
    packageRequires = [ exwm ];
    src = fetchFromGitHub {
      owner = "walseb";
      repo = "exwm-edit";
      rev = "2c79417922fd952b37cc5982861598f1bd38247d";
      sha256 = "0y1pqsz2m3c7lwzcnapc9605jyc6bxkynahq3sbz17sxdnxm5q6s";
    };
  };
  format-all = melpaBuild {
    pname = "format-all";
    ename = "format-all";
    version = "0.1.0";
    recipe = builtins.toFile "recipe" ''
      (format-all :repo "tobjaw/emacs-format-all-the-code"
                  :fetcher github)
    '';
    src = fetchFromGitHub {
      owner = "tobjaw";
      repo = "emacs-format-all-the-code";
      rev = "63021b8b56663445e4708a2e396b09911fc198e7";
      sha256 = "0d8nlgi1bc2c9886ccb8jqz4xygksgp575m8ksjm7xsbgmsm7vsa";
    };
  };
  move-border = melpaBuild {
    pname = "move-border";
    ename = "move-border";
    version = "0.1";
    recipe = builtins.toFile "recipe" ''
      (move-border :repo "ramnes/move-border"
                   :fetcher github)
    '';
    src = fetchFromGitHub {
      owner = "ramnes";
      repo = "move-border";
      rev = "79787ae93129fd98029c74780a79a2b659803061";
      sha256 = "0syazkswcdf9wv561nlfr9zx32hfwh9mjlbjrqhb5g6l5367f81b";
    };
  };
  xelb = melpaBuild {
    pname = "xelb";
    ename = "xelb";
    version = "0.17";
    recipe = builtins.toFile "recipe" ''
      (xelb :fetcher github
            :repo "ch11ng/xelb")
    '';
    packageRequires = [ cl-generic emacs ];
    src = fetchFromGitHub {
      owner = "ch11ng";
      repo = "xelb";
      rev = "01d06865d45a996a0eecf01a7a8700d338bb6889";
      # nix-prefetch-url --unpack https://github.com/<owner>/<repo>/archive/<rev>.tar.gz
      sha256 = "094366n6k71bnsg79kk9hvwq6slq6a6a2amlmdmn3746lfqynsxg";
    };
  };

in emacsWithPackages (epkgs:
(with epkgs.elpaPackages; [ company which-key ]) ++ (with epkgs.melpaPackages; [
  aggressive-indent
  aio
  all-the-icons
  auto-indent-mode
  company-nixos-options
  counsel
  counsel-projectile
  dash
  diff-hl
  elisp-demos
  evil
  evil-collection
  evil-commentary
  evil-magit
  evil-matchit
  evil-surround
  flycheck
  flycheck-package
  git-timemachine
  general
  golden-ratio
  helpful
  hl-todo
  hydra
  iflipb
  ivy
  ivy-hydra
  json-mode
  lispyville
  magit
  magit-popup
  magit-todos
  major-mode-hydra
  nix-mode
  nix-sandbox
  nix-update
  nixos-options
  org-projectile
  package-lint
  projectile
  rainbow-delimiters
  restart-emacs
  rg
  smartparens
  smex
  swiper
  symon
  use-package
  ws-butler
  yaml-mode
  yasnippet
  yasnippet-snippets
  zenburn-theme
]) ++ (with epkgs.orgPackages; [ org org-plus-contrib ]) ++ [
  doom-modeline
  exwm
  exwm-edit
  format-all
  move-border
  xelb
  (runCommand "default.el" { } ''
    mkdir -p $out/share/emacs/site-lisp
    echo '(message "site-lisp loaded")' > $out/share/emacs/site-lisp/default.el
  '')
])
