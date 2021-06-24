(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
;;(defconst *is-a-mac* (eq system-type 'darwin))

(let ((normal-gc-cons-threshold (* 20 1024 1024))
      (init-gc-cons-threshold (* 128 1024 1024)))
  (setq gc-cons-threshold init-gc-cons-threshold)
  (add-hook 'emacs-startup-hook
            (lambda () (setq gc-cons-threshold normal-gc-cons-threshold))))

(require 'init-benchmarking)
(require 'init-elpa)
(require 'init-ui)
(require 'init-settings)

(require 'init-common)
(require 'init-minibuffer-tool)
(require 'init-org)
(require 'init-term)
(require 'init-projectile)

(require 'init-lsp)
(require 'init-lsp-java)
(require 'init-lsp-flutter)

(require 'init-python)
(require 'init-leetcode)
(require 'init-nginx)
(require 'init-my)


