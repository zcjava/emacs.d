(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
;;(defconst *is-a-mac* (eq system-type 'darwin))

;;(let ((normal-gc-cons-threshold (* 20 1024 1024))
;;     (init-gc-cons-threshold (* 128 1024 1024)))
;; (setq gc-cons-threshold init-gc-cons-threshold)
;; (add-hook 'emacs-startup-hook
;;           (lambda () (setq gc-cons-threshold normal-gc-cons-threshold))))
(let ((init-gc-cons-threshold (* 128 1024 1024)))
  (setq gc-cons-threshold init-gc-cons-threshold)
  (add-hook 'emacs-startup-hook
            (lambda () (setq gc-cons-threshold (* 20 1024 1024)))))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-benchmarking)
(require 'init-elpa)
(require 'init-my)
(require 'init-proxy)
(require 'init-recentf)
(require 'init-ui)
(require 'init-settings)
(require 'init-common)
(require 'init-projectile)
(require 'init-minibuffer-tool)
(require 'init-org)
(require 'init-term)
(require 'init-lsp)
(require 'init-lsp-java)
;;(require 'init-lsp-flutter)
;;(require 'init-python)
;;(require 'init-leetcode)
(require 'init-nginx)
(require 'init-http)
;;Tip

;;;;;;;;;;;;;vterm;;;;;;;;;;;;;;;;;;;
;; vterm编译需要安装cmake、libtool    ;;
;; brew install cmake              ;;
;; brew install libtool            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;all-the-icons;;;;;;;;;;;
;; all-the-icons需要fontconfig支持  ;;
;; brew install fontconfig         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;==========other third elpa==========
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; awesome-tab https://github.com/manateelazycat/awesome-tab
;; emacs-nexus https://github.com/juergenhoetzel/emacs-nexus
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
