;;屏幕最大化
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;;隐藏菜单栏
(menu-bar-mode nil)
;;隐藏工具栏
;;(tool-bar-mode nil)
(tool-bar-mode -1)
;;隐藏滚动条
(scroll-bar-mode nil)

(setq inhibit-startup-message t)
;;(setq inhibit-message nil)

;;==========theme==========
(use-package dracula-theme
  :ensure t
  )

(load-theme 'dracula t)
;;==========theme end==========

;; 设置显示字体和大小
;;(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-16"))

(set-face-attribute 'default nil :font "DejaVu Sans Mono-17")

(global-font-lock-mode t)
(setq font-lock-maximum-size 5000000)

;;==========mode line 美化显示==========
(use-package nyan-mode
  :ensure t
  :init
  (setq nyan-animate-nyancat t)
  (setq nyan-wavy-trail t)
  (setq nyan-minimum-window-width 80)
  (setq nyan-bar-length 20)
  (nyan-mode))


(use-package doom-modeline
  :ensure t
  :config
  (doom-modeline-def-modeline 'ownml
    '(bar matches buffer-info remote-host buffer-position misc-info major-mode) 
    '(input-method buffer-encoding process vcs checker))

  ;; Add to `doom-modeline-mode-hook` or other hooks
  (defun setup-custom-doom-modeline ()
    (doom-modeline-set-modeline 'ownml 'default))
  (add-hook 'doom-modeline-mode-hook 'setup-custom-doom-modeline)
  )


(doom-modeline-mode t)
;;==========mode line 美化显示 end==========


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Show paren mode, built-in from Emacs 24.x   光标悬停代码块加底色
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(show-paren-mode t)
(setq show-paren-style 'expression)

(use-package paren)
(set-face-background 'show-paren-match (face-background 'default))
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

;; Sub word support
(add-hook 'minibuffer-setup-hook 'subword-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;skybert;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ws-butler cleans up whitespace only on the lines you've edited,
;; keeping messy colleagues happy ;-) Important that it doesn't clean
;; the whitespace on currrent line, otherwise, eclim leaves messy
;; code behind.

(use-package all-the-icons)
(use-package all-the-icons-dired)

(provide 'init-ui)
