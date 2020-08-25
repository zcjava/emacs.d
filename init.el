(setq inhibit-startup-message t)

(require 'package)
(setq package-enable-at-startup nil)

(add-to-list 'package-archives
	     '("melpa" . "http://elpa.emacs-china.org/melpa/"))

(package-initialize)

;;不保留备份文件  eg:  init.el~之类的文件
(setq make-backup-files nil)

;; unless 的含义是 if nil  do body
;; 当没有安装包，则执行刷新package并安装package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;;命令补全列表
(use-package which-key
  :ensure t  ;;是否一定要确保已安装
  :config (which-key-mode))

;; org 漂亮排版
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  )

(require 'dracula-theme)
(load-theme 'dracula t)

;; 设置全局的代码补全
(global-company-mode)

(set-face-attribute 'default nil :font "Menlo-16")



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("24714e2cb4a9d6ec1335de295966906474fdb668429549416ed8636196cb1441" default))
 '(package-selected-packages
   '(org-bullets which-key use-package json-mode dracula-theme company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
