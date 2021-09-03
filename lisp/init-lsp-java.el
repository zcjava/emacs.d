;;==========java==========
(setenv "JAVA_HOME"  "/Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home/")
(setq my-java-path "/Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home/bin/java")
(use-package lsp-java
  :init
  (setq lsp-java-server-install-dir (expand-file-name "~/.emacs.d/emacs-lsp-java/lsp-java-server/"))
  (setq lsp-java-java-path my-java-path)
  (setq lombok-jar-path
        (expand-file-name "~/data/mavenrepo/org/projectlombok/lombok/1.18.10/lombok-1.18.10.jar"))
  (setq lsp-java-vmargs
        `("-noverify"
          "-Xmx1G"
          "-XX:+UseG1GC"
          "-XX:+UseStringDeduplication"
          ,(concat "-javaagent:" lombok-jar-path)
          ;;          ,(concat "-Xbootclasspath/a:" lombok-jar-path)
          ))
  (setq lsp-groovy-server-file (expand-file-name "~/.emacs.d/emacs-lsp-java/groovy-language-server/groovy-language-server-all.jar"))
  (setq lsp-java-configuration-maven-user-settings (expand-file-name "~/.m2/settings.xml"))
  (setq lsp-java-maven-download-sources t)
  (setq lsp-java-import-maven-enabled t)
  (setq lsp-java-implementations-code-lens-enabled t)
  (setq lsp-java-references-code-lens-enabled t)
  (setq lsp-java-autobuild-enabled t)
  ;;  (setq lsp-java-save-actions-organize-imports t)
  :config
  (setq lsp-java-format-settings-url "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml" lsp-java-format-settings-profile "GoogleStyle")
  (setq lsp-java-format-enabled t)
  (setq lsp-java-format-comments-enabled t)
  ;;  (setq lsp-java-configuration-check-project-settings-exclusions t)
  (add-hook 'java-mode-hook 'lsp)
  (add-hook 'java-mode-hook 'lsp-deferred)
  (add-hook 'java-mode-hook 'lsp-java-boot-lens-mode)
  (add-hook 'before-save-hook 'lsp-format-buffer)
  ;; git clone git@github.com:juergenhoetzel/emacs-nexus.git ~/.emacs.d/site-lisp/
  (add-to-list 'load-path  (expand-file-name "site-lisp/emacs-nexus" user-emacs-directory))
  (require 'nexus)
  (setq nexus-rest-url "https://nexus.peoplecommnue.com/nexus/service/local/lucene/search")
  ;;  (add-hook 'before-save-hook 'lsp-java-format)
  ;;==========load maven pom mode==========
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; (add-to-list 'load-path  (expand-file-name "site-lisp/maven-pom-mode" user-emacs-directory)) ;;
  ;; (add-to-list 'auto-mode-alist '("pom.xml" . maven-pom-mode))                                 ;;
  ;; (load "maven-pom-mode")                                                                      ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;==========load maven pom mode end==========
  )

(use-package dap-mode
  :init
  ;;  (setq dap-java-test-additional-args '("-n" "\".*(Test|IT).*\""))
  (setq dap-java-java-command my-java-path)
  :ensure t
  :after (lsp-mode)
  :functions dap-hydra/nil
  :bind (:map lsp-mode-map
              ("<f5>" . dap-debug)
              ("M-<f5>" . dap-hydra))
  :hook ((dap-mode . dap-ui-mode)
         (dap-session-created . (lambda (&_rest) (dap-hydra)))
         (dap-terminated . (lambda (&_rest) (dap-hydra/nil))))
  :config
  (require 'dap-java)
  (dap-mode t)
  (dap-ui-mode t)
  (dap-tooltip-mode 1)
  (tooltip-mode 1)
  ;;  (dap-ui-controls-mode 1)
  (dap-register-debug-template
   "localhost:5005"
   (list :type "java"
         :request "attach"
         :hostName "localhost"
         :port 5005))
  (dap-register-debug-template
   "lxd"
   (list :type "java"
         :request "attach"
         :hostName "127.0.0.1"
         :port 5005))
  )

(use-package dap-java
  :ensure nil
  :after (lsp-java)

  ;; The :bind here makes use-package fail to lead the dap-java block!
  ;; :bind
  ;; (("C-c R" . dap-java-run-test-class)
  ;;  ("C-c d" . dap-java-debug-test-method)
  ;;  ("C-c r" . dap-java-run-test-method)
  ;;  )

  :config
  (global-set-key (kbd "<f7>") 'dap-step-in)
  (global-set-key (kbd "<f8>") 'dap-next)
  (global-set-key (kbd "<f9>") 'dap-continue)
  )
;;==========java end==========

;;==========maven pom ==========
;; git clone https://github.com/m0smith/maven-pom-mode.git ~/.emacs.d/elpa/


;;(load "maven-pom-mode")

;;==========maven pom end==========

(use-package mvn
  :ensure t
  )

(require 'lsp-java-boot)
;; to enable the lenses
(add-hook 'lsp-mode-hook #'lsp-lens-mode)
(add-hook 'java-mode-hook #'lsp-java-boot-lens-mode)


(provide 'init-lsp-java)
