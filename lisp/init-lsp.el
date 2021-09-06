(use-package lsp-mode
  :ensure t
  :hook (
         (lsp-mode . lsp-enable-which-key-integration)
         (nxml-mode . lsp)     ;; nxml-mode  自动加载lsp
         )
  :commands lsp  ;;lsp-mode取个别名,命令行输入lsp
  :bind
  (:map lsp-mode-map
        (("\C-\M-b" . lsp-find-implementation)
         ("M-RET" . lsp-execute-code-action)))
  :init (setq
         lsp-keymap-prefix "C-c l"              ; this is for which-key integration documentation, need to use lsp-mode-map
         read-process-output-max (* 1024 1024)  ; 1 mb
         lsp-completion-provider :capf
         lsp-idle-delay 0.500
         )
  :config
  (setq lsp-intelephense-multi-root nil) ; don't scan unnecessary projects
  (with-eval-after-load 'lsp-intelephense
    (setf (lsp--client-multi-root (gethash 'iph lsp-clients)) nil))
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
  (add-hook 'before-save-hook 'lsp-format-buffer)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; (setq                                 ;;
  ;;  ;; 关闭lsp debug信息                 ;;
  ;;  ;; lsp-inhibit-message t             ;;
  ;;  lsp-eldoc-render-all nil             ;;
  ;;  lsp-enable-file-watchers nil         ;;
  ;;  lsp-enable-symbol-highlighting nil   ;;
  ;;  lsp-headerline-breadcrumb-enable nil ;;
  ;;  lsp-highlight-symbol-at-point nil    ;;
  ;;  lsp-modeline-code-actions-enable nil ;;
  ;;  lsp-modeline-diagnostics-enable nil  ;;
  ;;  )                                    ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; Performance tweaks, see
  ;; https://github.com/emacs-lsp/lsp-mode#performance

  )

(use-package lsp-ui
  :after (lsp-mode)
  :init (setq lsp-ui-doc-delay 1.5
              lsp-ui-doc-position 'bottom
	          lsp-ui-doc-max-width 100)
  :bind (:map lsp-ui-mode-map
              ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
              ([remap xref-find-references] . lsp-ui-peek-find-references))
  ;; :config
  ;; (setq lsp-prefer-flymake nil
  ;;       lsp-ui-sideline-enable nil
  ;;       lsp-ui-sideline-show-symbol nil)
  )

;;(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)



(use-package treemacs
  :ensure t
  :commands (treemacs)
  :after (lsp-mode))

(use-package lsp-treemacs
  :after (lsp-mode treemacs)
  :config
  (global-set-key (kbd "M-s-.") 'lsp-treemacs-implementations)
  :ensure t
  :commands lsp-treemacs-errors-list
  :bind (:map lsp-mode-map
              ("M-9" . lsp-treemacs-errors-list)))


;;(use-package gradle-mode)
;;(use-package yaml-mode)
;;(use-package groovy-mode)

;; (use-package company-lsp
;;   :ensure t)


(use-package quickrun
  :ensure t
  :bind ("C-c r" . quickrun))


;;==========xml lsp==========
(setq lsp-xml-jar-file (expand-file-name "site-lisp/lsp-server/xmlls/org.eclipse.lemminx-0.13.1-uber.jar" user-emacs-directory))
(setq lsp-xml-server-command `("java" "-cp" "/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven-0.4.0.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/maven-core-3.8.2.jar" "-jar" ,lsp-xml-jar-file))

(provide 'init-lsp)
