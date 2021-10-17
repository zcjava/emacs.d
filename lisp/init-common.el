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
  )
(use-package yasnippet-snippets :ensure t)
(add-hook 'prog-mode-hook 'hs-minor-mode)

;;==========xml处理==========
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (add-to-list 'auto-mode-alist '("\\.\\(xml\\|xsl\\|rng\\|xhtml\\|lzx\\|x3d\\)\\'" . nxml-mode)) ;;
;; (setq rng-schema-locating-files (list (expand-file-name "~/.emacs.d/schema/schemas.xml")))      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(use-package pdf-tools
  :ensure t
  )
(add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode))

(use-package magit
  :ensure t
  )


(use-package format-all
  :ensure t
  :hook (elixir-mode . format-all-mode)
  :hook (emacs-lisp-mode . format-all-mode)
  ;; or for all program languages
  :hook (prog-mode . format-all-mode)
  ;; change default formatter manually
  :init
  (setq formatters '((lsp-mode . "lsp-format-buffer")))
  :config
  (add-hook 'format-all-mode-hook 'format-all-ensure-formatter)
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

(use-package company-english-helper
  :load-path (lambda () (expand-file-name "site-lisp/company-english-helper/" user-emacs-directory))
  :bind ("C-c C-e" . toggle-company-english-helper)
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
;; git clone --depth=1 https://github.com/manateelazycat/awesome-tab.git ~/.emacs.d/site-lisp/awesome-tab/

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
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; :ensure t                                              ;;
  ;; :init                                                  ;;
  ;; (helm-mode 1)                                          ;;
  ;; (progn (setq helm-buffers-fuzzy-matching t))           ;;
  ;; :bind                                                  ;;
  ;; (("C-c h" . helm-command-prefix))                      ;;
  ;; (("M-x" . helm-M-x))                                   ;;
  ;; (("C-x C-f" . helm-find-files))                        ;;
  ;; (("C-x b" . helm-buffers-list))                        ;;
  ;; (("C-c b" . helm-bookmarks))                           ;;
  ;; (("C-c f" . helm-recentf))   ;; Add new key to recentf ;;
  ;; (("C-c g" . helm-grep-do-git-grep))                    ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  )  ;; Search using grep in a git project
(use-package helm-descbinds
  :ensure t
  :bind ("C-h b" . helm-descbinds)
  )

(use-package dash
  )

(use-package helm-dash
  ;; :init
  ;; (setq helm-dash-browser-func 'eww)
  )

(use-package iedit
  :bind ("C-c e" . iedit-mode)
  )

;;==========helm dash end==========
(use-package diminish)
(use-package scratch)
(use-package command-log-mode)

;;==========treemacs==========
(use-package treemacs
  :ensure t
  :defer t
  :hook (projectile-after-switch-project . treemacs-display-current-project-exclusively)
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   t
          treemacs-file-event-delay                5000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-mode             t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-width                           35
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil
          )

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :after (treemacs dired)
  :ensure t
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

;;(add-hook 'projectile-after-switch-project-hook 'treemacs-display-current-project-exclusively)
;;==========treemacs end==========

(use-package expand-region
  )
;;选中当前区域语句块
(global-set-key (kbd "C-=") 'er/expand-region)


(use-package slime
  :init
  (setq inferior-lisp-program "sbcl")
  )
(provide 'init-common)
