;; 删除所有的空格，直到下一个非空格字符
(use-package hungry-delete
  :ensure t
  :bind (
	     ("C-c DEL" . hungry-delete-backward)
	     ("C-c d" . hungry-delete-forward))
  )

;; ;; 和hungry-delete类似，去掉当前字符前的所有的空格
;; (use-package ws-butler
;;   :init
;;   (setq ws-butler-keep-whitespace-before-point nil)
;;   :config
;;   (ws-butler-global-mode))



;;显示当前不完全命令的快捷键对应的命令列表
(use-package which-key
  :ensure t  ;;是否一定要确保已安装
  :bind ("M-m" . which-key-show-top-level)  ;; 绑定超级键，顶层命令列表
  )
(which-key-mode)

;;==========flycheck==========
(use-package flycheck
  :init (global-flycheck-mode)
  :ensure t
  )
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
;;==========flycheck end==========


;;==========smartparens==========
;;自动补全符号
(use-package smartparens
  :ensure t
  )

(smartparens-global-mode t)
;;==========smartparens end==========


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


(defhydra hydra-buffer-menu (:color pink  :hint nil)
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

(use-package yasnippet
  :config (yas-global-mode)
  (use-package yasnippet-snippets :ensure t)
  )

(add-hook 'prog-mode-hook 'hs-minor-mode)

;;==========xml处理==========
(add-to-list 'auto-mode-alist '("\\.\\(xml\\|xsl\\|rng\\|xhtml\\|lzx\\|x3d\\)\\'" . nxml-mode))
(setq rng-schema-locating-files (list (expand-file-name "~/.emacs.d/schema/schemas.xml")))


(use-package pdf-tools
  :ensure t
  )
(add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode))

(use-package magit
  :ensure t
  )


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

(global-set-key (kbd "C-c z") 'zoom)
;;==========zoom end==========

;;==========awesome-tab==========
;;awesome-tab 不在elpa里,使用需要自行下载到elpa里面,命令如下:
;; git clone --depth=1 https://github.com/manateelazycat/awesome-tab.git ~/.emacs.d/elpa/awesome-tab/
(use-package awesome-tab
  :load-path (lambda () (expand-file-name "site-lisp/awesome-tab/" user-emacs-directory))
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


;;==========dumb-jump==========

(use-package dumb-jump
  :ensure t
  )
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
;;==========dumb-jump==========

(use-package json-mode
  )

;;==========vue==========
(use-package vue-mode
  :mode "\\.vue\\'"
  :hook (vue-mode . prettier-js-mode)
  :config
  (add-hook 'vue-mode-hook 'lsp)
  (setq prettier-js-args '("--parser vue"))
  )
;;==========vue==========

;;==========undo tree==========
(use-package undo-tree
  )
(global-undo-tree-mode t)
;;==========undo tree end==========
;;==========avy==========
(use-package avy
  :ensure t
  :config
  (global-set-key (kbd "C-;") 'avy-goto-char)
  )
;;==========avy==========


(use-package youdao-dictionary
  :init
  (setq url-automatic-caching t)
  (setq youdao-dictionary-search-history-file "~/.emacs.d/.youdao")
  :ensure t
  )

(global-set-key (kbd "C-c y w") 'youdao-dictionary-search-at-point)
(global-set-key (kbd "C-c y v") 'youdao-dictionary-play-voice-at-point)
(global-set-key (kbd "C-c y s") 'youdao-dictionary-search-from-input)


;;==========multiple cursor==========
(use-package multiple-cursors
  )
(global-set-key (kbd "C-c m e") 'mc/edit-lines)
(global-set-key (kbd "C-c m n") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c m p") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c m a") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c m w") 'mc/mark-next-like-this-word)

(add-to-list 'mc/unsupported-minor-modes 'flyspell-mode)
;;==========multiple cursor end==========

;;==========helm dash==========
(use-package helm
  )
(use-package dash
  )
(use-package helm-dash
  ;; :init
  ;; (setq helm-dash-browser-func 'eww)
  )


;;==========helm dash end==========
(use-package diminish)
(use-package scratch)
(use-package command-log-mode)

(provide 'init-common)
