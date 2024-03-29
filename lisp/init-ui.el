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

;; 设置光标的颜色和类型
(setq-default cursor-type 'bar)
(set-cursor-color "green")
;;(set-face-background hl-line-face "dark gray")
(global-hl-line-mode t)

;; 设置显示字体和大小
;;(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-16"))
(set-face-attribute 'default nil :font "DejaVu Sans Mono-18")
;;(set-face-attribute 'org-mode nil :font "Ubuntu Mono-18")
;; org-mode table 设置等宽字体才能使得table对齐
(with-eval-after-load 'org
  (defun org-buffer-face-mode-variable ()
    (interactive)
    (make-face 'width-font-face)
    (set-face-attribute 'width-font-face nil :font "Ubuntu Mono 20")
    (setq buffer-face-mode-face 'width-font-face)
    (buffer-face-mode))
  (add-hook 'org-mode-hook 'org-buffer-face-mode-variable))


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
  :init (doom-modeline-mode t)
  :config
  (setq doom-modeline-height 5)
  (custom-set-faces
   '(mode-line ((t (:family "Ubuntu Mono" :height:50))))
   '(mode-line-inactive ((t (:family "Ubuntu Mono" :height:50))))
   )
  (doom-modeline-def-modeline 'ownml
    '(bar matches buffer-info remote-host buffer-position misc-info major-mode)
    '(input-method buffer-encoding process vcs checker))
  ;; Add to `doom-modeline-mode-hook` or other hooks
  (defun setup-custom-doom-modeline ()
    (doom-modeline-set-modeline 'ownml 'default))
  (add-hook 'doom-modeline-mode-hook 'setup-custom-doom-modeline)
  )
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
