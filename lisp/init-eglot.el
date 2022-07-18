(define-derived-mode genehack-vue-mode web-mode "ghVue"
  "A major mode derived from web-mode, for editing .vue files with LSP support.")


;; (defun my-eglot-keybindgs ()
;;   (define-key evil-motion-state-map "gR" #'eglot-rename)
;;   (define-key evil-motion-state-map "gr" #'xref-find-references)
;;   (define-key evil-normal-state-map "gi" #'eglot-find-implementation)
;;   (define-key evil-motion-state-map "gh" #'eldoc)
;;   (define-key evil-normal-state-map "ga" #'eglot-code-actions))

;; (use-package prettier-js
;;   :ensure t
;;   :config
;;   (setq prettier-js-args '(
;;                            "--print-width" "100"  ;;一行代码的最大字符数,默认是80
;;                            "--trailing-comma" "all"  ;; 尾部逗号处理
;;                            "--bracket-spacing" "false" ;; > 是否另起一行
;;                            ))
;;   )

(use-package web-mode
  :ensure t
  :config
  ;;  (format-all-mode nil)
  ;;  (add-hook 'web-mode-hook 'prettier-js-mode)
  )

(use-package eglot
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.vue\\'" . genehack-vue-mode))
  (add-to-list 'auto-mode-alist '("\\.\\(html\\|css\\)\\'" . web-mode))
  ;;  (advice-add 'eglot-ensure :after 'my-eglot-keybindgs)
  :bind (:map eglot-mode-map
              ("C-c l a" . eglot-code-actions)
              ("C-c l r" . eglot-rename)
              ("C-c l o" . eglot-code-action-organize-imports)
              ("C-c l f" . eglot-format)
              ("C-c l d" . eldoc)
              ("s-<return>" . eglot-code-actions))
  :hook
  ;; (css-mode . eglot-ensure)
  ;; (js2-mode . eglot-ensure)
  ;; (js-mode . eglot-ensure)
  ;; (web-mode . eglot-ensure)
  ;; (genehack-vue-mode . eglot-ensure)
  (rust-mode . eglot-ensure)
  :config
  (setq eglot-send-changes-idle-time 0.2)
  (add-to-list 'eglot-server-programs '(genehack-vue-mode "vls"))
  (add-to-list 'eglot-server-programs '(rust-mode "rust-analyzer"))
  (add-to-list 'eglot-server-programs '(web-mode . ("vscode-html-language-server" "--stdio")))

  (setq read-process-output-max (* 1024 1024))
  (push :documentHighlightProvider eglot-ignored-server-capabilities)
  (setq eldoc-echo-area-use-multiline-p nil))


(provide 'init-eglot)
