;;==========python==========

;; (use-package python-mode
;;   :init
;;   (add-hook 'python-mode-hook
;;             (lambda ()
;;               (setq tab-width 4)
;;               (setq python-indent-offset 4)
;;               (setq global-flycheck-mode 1)
;;               )
;;             ))


(use-package lsp-pyright
  :ensure t
  :config
  (setq lsp-pyright-auto-import-completions t)
  (setq lsp-pyright-auto-search-paths t)
  (setq lsp-pyright-python-executable-cmd "python3")
  (setq lsp-pyright-extra-paths (list"/opt/homebrew/Cellar/python@3.9/3.9.10/Frameworks/Python.framework/Versions/3.9/lib/python3.9/site-packages/" "."))
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp))))  ; or lsp-deferred

(use-package flycheck-pyflakes
  )
;;==========python end==========

(provide 'init-lsp-python)
