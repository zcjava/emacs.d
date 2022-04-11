
(use-package lsp-mode
  :ensure t
  :hook (
         (lsp-mode . lsp-enable-which-key-integration)
         (nxml-mode . lsp)     ;; nxml-mode  自动加载lsp
         (web-mode . lsp)
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
         lsp-vetur-validation-template nil
         lsp-vetur-dev-log-level "DEBUG"
         lsp-vetur-format-default-formatter-css "none"
         lsp-vetur-format-default-formatter-html "none"
         lsp-vetur-format-default-formatter-js "none"
         lsp-headerline-breadcrumb-enable nil
         )
  :config
  (setq lsp-completion-enable-additional-text-edit nil)
  (setq lsp-intelephense-multi-root nil) ; don't scan unnecessary projects
  (with-eval-after-load 'lsp-intelephense
    (setf (lsp--client-multi-root (gethash 'iph lsp-clients)) nil))
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
  (add-hook 'lsp-mode-hook 'lsp-lens-mode)
  (add-hook 'lsp-mode-hook
            (lambda()
              (add-hook 'before-save-hook 'lsp-format-buffer nil t)))

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
(use-package lsp-ivy
  :after (lsp-mode)
  :commands lsp-ivy-workspace-symbol
  :init (define-key lsp-mode-map [remap xref-find-apropos] #'lsp-ivy-workspace-symbol)
  )

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
;;    :ensure t)

(use-package dap-mode
  :init
  ;;  (setq dap-java-test-additional-args '("-n" "\".*(Test|IT).*\""))
  ;;  (setq dap-java-java-command my-java-path)
  :ensure t
  :after (lsp-mode)
  :functions dap-hydra/nil
  :hook ((dap-mode . dap-ui-mode)
         (dap-session-created . (lambda (&_rest) (dap-hydra)))
         (dap-terminated . (lambda (&_rest) (dap-hydra/nil))))
  :config
  ;; :bind (:map lsp-mode-map
  ;;             ("<f5>" . dap-debug)
  ;;             ("M-<f5>" . dap-hydra))
  ;; (dap-ui-mode t)
  ;; (dap-tooltip-mode 1)
  ;; (tooltip-mode 1)
  ;;  (dap-ui-controls-mode 1)

  )


(use-package quickrun
  :ensure t
  :bind ("C-c r" . quickrun))


;;==========xml lsp==========
(setq lsp-xml-jar-file (expand-file-name "site-lisp/lsp-server/xmlls/org.eclipse.lemminx-0.13.1-uber.jar" user-emacs-directory))



(setq lsp-xml-server-command `("java" "-classpath" "/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/aether-api-1.1.0.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/aether-connector-basic-1.1.0.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/aether-connector-okhttp-0.17.8.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/aether-spi-1.1.0.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/aether-util-1.1.0.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/aopalliance-1.0.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/cdi-api-1.0.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/commons-cli-1.4.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/commons-codec-1.11.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/commons-io-2.5.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/gson-2.8.2.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/guice-4.2.3-no_aop.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/httpclient-4.5.12.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/httpcore-4.4.13.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/indexer-core-6.0.0.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/javax.annotation-api-1.2.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/javax.inject-1.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/jcl-over-slf4j-1.7.25.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/jsr250-api-1.0.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/jsr305-3.0.2.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/lemminx-maven-0.4.1-SNAPSHOT.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/lucene-analyzers-common-5.5.5.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/lucene-backward-codecs-5.5.5.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/lucene-core-5.5.5.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/lucene-highlighter-5.5.5.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/lucene-join-5.5.5.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/lucene-memory-5.5.5.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/lucene-queries-5.5.5.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/lucene-queryparser-5.5.5.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/lucene-sandbox-5.5.5.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/maven-artifact-3.8.1.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/maven-builder-support-3.8.1.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/maven-compat-3.8.1.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/maven-core-3.8.1.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/maven-embedder-3.8.1.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/maven-model-3.8.1.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/maven-model-builder-3.8.1.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/maven-plugin-api-3.8.1.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/maven-repository-metadata-3.8.1.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/maven-resolver-api-1.6.2.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/maven-resolver-impl-1.6.1.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/maven-resolver-provider-3.8.1.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/maven-resolver-spi-1.6.2.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/maven-resolver-util-1.6.2.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/maven-settings-3.8.1.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/maven-settings-builder-3.8.1.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/maven-shared-utils-3.2.1.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/okhttp-3.14.1.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/okio-1.17.3.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/org.eclipse.lemminx-0.18.0.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/org.eclipse.lsp4j-0.11.0.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/org.eclipse.lsp4j.generator-0.11.0.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/org.eclipse.lsp4j.jsonrpc-0.11.0.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/org.eclipse.sisu.inject-0.3.4.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/org.eclipse.sisu.plexus-0.3.4.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/org.eclipse.xtend.lib-2.24.0.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/org.eclipse.xtend.lib.macro-2.24.0.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/org.eclipse.xtext.xbase.lib-2.24.0.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/plexus-cipher-1.7.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/plexus-classworlds-2.6.0.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/plexus-component-annotations-2.1.0.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/plexus-interpolation-1.25.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/plexus-sec-dispatcher-1.4.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/plexus-utils-3.2.1.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/remark-1.0.0.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/slf4j-api-1.7.29.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/wagon-file-3.4.2.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/wagon-http-3.4.2.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/wagon-http-shared-3.4.2.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/wagon-provider-api-3.4.3.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/xercesImpl-2.12.1.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/xml-apis-1.4.01.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/xml-resolver-1.2.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/commons-lang3-3.4.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/guava-29.0-jre.jar:/Users/os/.emacs.d/site-lisp/lsp-server/xmlls/lemminx-maven/jsoup-1.9.2.jar" "org.eclipse.lemminx.XMLServerLauncher"))


(provide 'init-lsp)
