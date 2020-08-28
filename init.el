(setq inhibit-startup-message t)

(require 'package)
(setq package-enable-at-startup nil)
(setq use-package-always-ensure t)

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
;; 使用y/n 替代yes/no
(fset 'yes-or-no-p 'y-or-n-p)
;; unless 的含义是 if nil  do body
(unless (bound-and-true-p package--initialized)
  (package-initialize)) ;; 刷新软件源索引
(unless package-archive-contents
  (package-refresh-contents))
;; 当没有安装包，则执行刷新package并安装package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


;; 快读打开init.file
(defun open-ini-file()
  (interactive)
  (find-file "~/.emacs.d/init.el")
  )


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


(use-package counsel
  :ensure t
  ;;  :config (require 'swiper) (require 'counsel) ;; 依赖
  :hook (after-init . ivy-mode)
  )


(use-package projectile)

(use-package yasnippet
  :config
  (yas-global-mode)
  (setq yas-snippet-dirs '("~/.emacs.d/snippets/"))
  )

;;==========java==========
(use-package lsp-mode
  :hook ((lsp-mode . lsp-enable-which-key-integration))
  :config (setq lsp-completion-enable-additional-text-edit nil))

(use-package hydra)

(use-package lsp-ui)

(use-package which-key
  :config (which-key-mode))

(use-package lsp-java
  :config
  (add-hook 'java-mode-hook 'lsp)
  (setq lsp-java-server-install-dir (expand-file-name "~/.spacemacs.d/lsp-java-server/"))
  )

(use-package dap-mode
  :after lsp-mode
  :config (dap-auto-configure-mode))

(use-package dap-java
  :ensure nil)

(use-package helm-lsp)

(use-package helm
  :config (helm-mode))

(use-package lsp-treemacs)

(require 'lsp-java-boot)
;; to enable the lenses
(add-hook 'lsp-mode-hook #'lsp-lens-mode)
(add-hook 'java-mode-hook #'lsp-java-boot-lens-mode)

;;==========java==========


(use-package mvn
  :ensure t
  )

(use-package magit
  :ensure t
  )

;;(use-package yas

(use-package exec-path-from-shell
  :ensure t)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))


;; optional if you want which-key integration
(use-package which-key
  :config
  (which-key-mode))




(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)


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


(use-package format-all
  :ensure t
  )

;; 设置全局的代码补全
(use-package company
  :ensure t
  :bind (
	 :map company-active-map
	 (("C-n" . company-select-next)
	  ("C-p" . company-select-previous)
	  ("C-d" . company-show-doc-buffer)
	  ))
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
   '(magit ivy hungry-delete org-bullets which-key use-package json-mode dracula-theme company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
