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

;;==========utf8==========
;; 设置emacs 使用 utf-8
(setq locale-coding-system 'utf-8)
;; 设置键盘输入时的字符编码
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
;; 文件默认保存为 utf-8
(set-buffer-file-coding-system 'utf-8)
(set-default buffer-file-coding-system 'utf8)
(set-default-coding-systems 'utf-8)
;; 解决粘贴中文出现乱码的问题
(set-clipboard-coding-system 'utf-8)
;; 终端中文乱码
(set-terminal-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))
;; 解决文件目录的中文名乱码
(setq-default pathname-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
;; 解决 Shell Mode(cmd) 下中文乱码问题
;;==========utf8 end==========
(setq auto-save-default nil)
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

;; (eval-and-compile
;;     (setq use-package-always-ensure t) ;不用每个包都手动添加:ensure t关键字
;;     (setq use-package-always-defer t) ;默认都是延迟加载，不用每个包都手动添加:defer t
;;     )

;; 开启全局行号显示
(use-package emacs
  :config
  ;;(setq display-line-numbers-type 'relative)
  (global-display-line-numbers-mode t))

(use-package hungry-delete
  :ensure t
  :bind (
	 ("C-c DEL" . hungry-delete-backward)
	 ("C-c d" . hungry-delete-forward))
  )

;;


;;命令补全列表 
(use-package which-key
  :ensure t  ;;是否一定要确保已安装
  :config (which-key-mode)
  :bind ("M-m" . which-key-show-top-level)  ;; 绑定超级键，顶层命令列表
  )

;;==========flycheck==========
(use-package flycheck
  :ensure t
  :hook (after-init . global-flycheck-mode))
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
;;==========flycheck==========

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

(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el")
  )

;;==========smartparens==========
;;自动补全符号
(use-package smartparens
  :ensure t
  )

(smartparens-global-mode t)

;;==========hydra==========
;;使用短快捷键组合列表来简化command
(use-package hydra
  :ensure t
  )

;;==========zoom in out==========
;; (defhydra hydra-zoom (global-map "M-m")
;;   "zoom"
;;   ("g" text-scale-increase "in")
;;   ("l" text-scale-decrease "out"))
;;==========zoom in out end==========


(defhydra hydra-buffer-menu (:color pink
                             :hint nil)
  "
^Mark^             ^Unmark^           ^Actions^          ^Search
-----------------------------------------------------------------
_m_: mark          _u_: unmark        _x_: execute       _R_: re-isearch
_s_: save          _U_: unmark up     _b_: bury          _I_: isearch
_d_: delete        ^ ^                _g_: refresh       _O_: multi-occur
_D_: delete up     ^ ^                _T_: files only: % -28`Buffer-menu-files-only
_~_: modified
"
  ("m" Buffer-menu-mark)
  ("u" Buffer-menu-unmark)
  ("U" Buffer-menu-backup-unmark)
  ("d" Buffer-menu-delete)
  ("D" Buffer-menu-delete-backwards)
  ("s" Buffer-menu-save)
  ("~" Buffer-menu-not-modified)
  ("x" Buffer-menu-execute)
  ("b" Buffer-menu-bury)
  ("g" revert-buffer)
  ("T" Buffer-menu-toggle-files-only)
  ("O" Buffer-menu-multi-occur :color blue)
  ("I" Buffer-menu-isearch-buffers :color blue)
  ("R" Buffer-menu-isearch-buffers-regexp :color blue)
  ("c" nil "cancel")
  ("v" Buffer-menu-select "select" :color blue)
  ("o" Buffer-menu-other-window "other-window" :color blue)
  ("q" quit-window "quit" :color blue))

(define-key Buffer-menu-mode-map "." 'hydra-buffer-menu/body)
;;==========hydra end==========



(use-package vterm
  :ensure t
  )

(use-package treemacs)

(treemacs)
(use-package projectile
  :config (projectile-mode)
  )

(use-package treemacs-projectile)

(use-package yasnippet :config (yas-global-mode))


;;==========java==========
(use-package lsp-mode
  :hook ((lsp-mode . lsp-enable-which-key-integration))
  :config (setq lsp-completion-enable-additional-text-edit nil)
  :commands lsp
  )

(use-package lsp-ui
  :commands lsp-ui-mode)

(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)

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


(use-package helm
  :config (helm-mode))

(use-package lsp-treemacs
  )


(require 'lsp-java-boot)
;; to enable the lenses
(add-hook 'lsp-mode-hook #'lsp-lens-mode)
(add-hook 'java-mode-hook #'lsp-java-boot-lens-mode)



(setq lsp-java-java-path "/usr/local/opt/openjdk@11/bin/java")
(setq lombok-jar-path
        (expand-file-name "~/.m2/repository/org/projectlombok/lombok/1.18.10/lombok-1.18.10.jar"))

(setq lsp-java-vmargs
        `("-noverify"
          "-Xmx1G"
          "-XX:+UseG1GC"
          "-XX:+UseStringDeduplication"
          ,(concat "-javaagent:" lombok-jar-path)
;;          ,(concat "-Xbootclasspath/a:" lombok-jar-path)
          ))
(setq lsp-groovy-server-file (expand-file-name "~/.spacemacs.d/groovy-language-server/groovy-language-server-all.jar"))

(setq lsp-java-configuration-maven-user-settings (expand-file-name "~/.m2/settings.xml"))
(setq lsp-java-maven-download-sources t)
(setq lsp-java-import-maven-enabled t)

;; 针对maven的pom和其他的xml 标签补全
(add-to-list 'auto-mode-alist '("\\.\\(xml\\|xsl\\|rng\\|xhtml\\|lzx\\|x3d\\)\\'" . nxml-mode))
(setq rng-schema-locating-files (list (expand-file-name "~/.emacs.d/schema/schemas.xml")))   


;;==========java end==========

(use-package pdf-tools
  :ensure t
  )
(add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode))
(use-package mvn
  :ensure t
  )

(use-package magit
  :ensure t
  )

;;(use-package yas

(use-package exec-path-from-shell
  :ensure t
  :config (setq exec-path (append exec-path '("/usr/local/bin")))
  )
(setq exec-path-from-shell-check-startup-files nil)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

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

;;==========company==========
;; 设置全局的代码补全
(use-package company
  :ensure t
  :bind (
         :map company-active-map
         (("C-n"   . company-select-next)
          ("C-p"   . company-select-previous)
          ("C-d"   . company-show-doc-buffer)
          ("<tab>" . company-complete))
         )
  )

(add-hook 'after-init-hook 'global-company-mode)
;;==========company end==========

;;==========switch-window==========
(use-package switch-window
  :ensure t
  :config
  (setq switch-window-shortcut-style 'qwerty)
  )

(global-set-key (kbd "C-x o") 'switch-window) 
;;==========switch-window end==========

;; (use-package window-numbering
;;   :ensure t
;;   :config
;;   (setq window-numbering-assign-func
;;       (lambda () (when (equal (buffer-name) "*Calculator*") 9)))
;;   )
;; (window-numbering-mode t)



;;==========zoom==========
;;让当前显示窗口能自动放大，显示更多的区域
(use-package zoom
  :ensure t
  :init
  (setq zoom-size '(0.718 . 0.718)) ;;设置显示区域的比例
  )

(zoom-mode t)
;;==========zoom end==========

;;==========awesome-tab==========
;;awesome-tab 不在elpa里,使用需要自行下载到elpa里面,命令如下:
;; git clone --depth=1 https://github.com/manateelazycat/awesome-tab.git ~/.emacs.d/elpa/awesome-tab/
(use-package awesome-tab
  :load-path (lambda () (expand-file-name "~/.emacs.d/elpa/awesome-tab/"))
  :config
  (awesome-tab-mode t)
  )
  ;; 使用mac command + N 就可以切换到对应的tab
  (global-set-key (kbd "s-1") 'awesome-tab-select-visible-tab)
  (global-set-key (kbd "s-2") 'awesome-tab-select-visible-tab)
  (global-set-key (kbd "s-3") 'awesome-tab-select-visible-tab)
  (global-set-key (kbd "s-4") 'awesome-tab-select-visible-tab)
  (global-set-key (kbd "s-5") 'awesome-tab-select-visible-tab)
  (global-set-key (kbd "s-6") 'awesome-tab-select-visible-tab)
  (global-set-key (kbd "s-7") 'awesome-tab-select-visible-tab)
  (global-set-key (kbd "s-8") 'awesome-tab-select-visible-tab)
  (global-set-key (kbd "s-9") 'awesome-tab-select-visible-tab)
  (global-set-key (kbd "s-0") 'awesome-tab-select-visible-tab)

;;==========awesome-tab end==========

;;字体设置
(set-face-attribute 'default nil :font "Menlo-16")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(window-number treemacs-projectile awesome-tab zoom window-numbering pdf-tools vterm smartparens yasnippet which-key use-package projectile org-bullets mvn magit lsp-ui lsp-java lsp-ivy hungry-delete helm-lsp format-all flycheck exec-path-from-shell dracula-theme counsel company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
