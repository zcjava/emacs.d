(setq inhibit-startup-message t)

(require 'package)
(setq package-enable-at-startup nil)

;;(add-to-list 'package-archives
;;	     '("melpa" . "http://elpa.emacs-china.org/melpa/"))
(setq package-archives '(
    ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/") 
    ("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
    ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))

(package-initialize)

;;隐藏菜单栏
(menu-bar-mode nil)
;;隐藏工具栏
;;(tool-bar-mode nil)
(tool-bar-mode -1)
;;隐藏滚动条
(scroll-bar-mode nil)

;;不保留备份文件  eg:  init.el~之类的文件
(setq make-backup-files nil)

;; unless 的含义是 if nil  do body
(unless (bound-and-true-p package--initialized) 
  (package-initialize)) ;; 刷新软件源索引
(unless package-archive-contents
  (package-refresh-contents))
;; 当没有安装包，则执行刷新package并安装package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; (eval-and-compile 
;;     (setq use-package-always-ensure t) ;不用每个包都手动添加:ensure t关键字 
;;     (setq use-package-always-defer t) ;默认都是延迟加载，不用每个包都手动添加:defer t
;;     )

;; 开启全局行号显示
(use-package emacs 
  :config 
;  (setq display-line-numbers-type 'relative) 
  (global-display-line-numbers-mode t))

(use-package hungry-delete
  :ensure t
  :bind (
	 ("C-c DEL" . hungry-delete-backward)
	 ("C-c d" . hungry-delete-forward))
  )

;;命令补全列表
(use-package which-key
  :ensure t  ;;是否一定要确保已安装
  :config (which-key-mode))

;;
(use-package flycheck
  :ensure t
  :hook (after-init . global-flycheck-mode))
;; org 漂亮排版
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  )

;; (use-package crux
;;   :ensure t
;;   :bind (
;; 	 ("M-m f e d" crux-find-user-init-file)
;; 	 ("C-c ^" . crux-top-join-line)
;; 	 )
;;   )

(use-package dracula-theme
  :ensure t
  )

(load-theme 'dracula t)

;; 设置全局的代码补全
(use-package company
  :ensure t
  )

(add-hook 'after-init-hook 'global-company-mode)


(set-face-attribute 'default nil :font "Menlo-16")



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("24714e2cb4a9d6ec1335de295966906474fdb668429549416ed8636196cb1441" default))
 '(package-selected-packages
   '(hungry-delete org-bullets which-key use-package json-mode dracula-theme company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
