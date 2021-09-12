;;==========java==========
(setenv "JAVA_HOME"  "/Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home/")

(setq my-java-path "/Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home/bin/java")

(use-package lsp-java
  :init
  (setq lsp-java-server-install-dir (expand-file-name "site-lisp/lsp-server/java/" user-emacs-directory))
  (setq lsp-java-java-path my-java-path)
  (setq lombok-jar-path
        (expand-file-name "~/data/mavenrepo/org/projectlombok/lombok/1.18.10/lombok-1.18.10.jar"))
  (setq lsp-java-vmargs
        `("-noverify"
          "-Xmx1G"
          "-XX:+UseG1GC"
          "-XX:+UseStringDeduplication"
          ,(concat "-javaagent:" lombok-jar-path)
          ))
  (setq lsp-java-configuration-maven-user-settings (expand-file-name "~/.m2/settings.xml"))
  (setq lsp-java-format-settings-url "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml" lsp-java-format-settings-profile "GoogleStyle")
  ;;  (setq lsp-groovy-server-file (expand-file-name "lsp-server/emacs-lsp-java/groovy-language-server/groovy-language-server-all.jar" user-emacs-directory))
  :config
  (setq lsp-java-maven-download-sources t)
  (setq lsp-java-import-maven-enabled t)
  (setq lsp-java-implementations-code-lens-enabled t)
  (setq lsp-java-references-code-lens-enabled t)
  (setq lsp-java-autobuild-enabled t)
  (setq lsp-java-format-enabled t)
  (setq lsp-java-format-comments-enabled t)
  (setq lsp-java-configuration-update-build-configuration t)
  (setq lsp-java-configuration-check-project-settings-exclusions t)
  (add-hook 'java-mode-hook 'lsp)
  (require 'lsp-java-boot)
  (add-hook 'lsp-mode-hook 'lsp-lens-mode)
  ;; 只在java-mode save的时候 调用lsp-java-origanize-imports
   ;; (add-hook 'java-mode-hook (lambda()
   ;;                            (lsp t)
   ;;                            (flycheck-mode t)
   ;;                            (company-mode t)
   ;;                            (lsp-ui-mode t)
   ;;                            (lsp-ui-doc-mode nil)
   ;;                            (lsp-java-boot-lens-mode t)
   ;;                            (dap-mode t)
   ;;                            (dap-ui-mode t)
   ;;                            (dap-tooltip-mode t)
   ;;                            (tooltip-mode t)
   ;;                            (dap-ui-controls-mode t)
   ;;                            ;;(gradle-mode t)
   ;;                            )) 
  (add-hook 'java-mode-hook
            (lambda()
              (add-hook 'before-save-hook 'lsp-java-organize-imports nil t)))
  )


(use-package dap-java
  :ensure nil
  ;; :config
  ;; (global-set-key (kbd "<f7>") 'dap-step-in)
  ;; (global-set-key (kbd "<f8>") 'dap-next)
  ;; (global-set-key (kbd "<f9>") 'dap-continue)
  )

;; (require 'lsp-java-boot)
;; ;; to enable the lenses
;; (add-hook 'lsp-mode-hook #'lsp-lens-mode)
;; (add-hook 'java-mode-hook #'lsp-java-boot-lens-mode)

;;==========java end==========

;;========== maven pom==========
;; https://github.com/m0smith/maven-pom-mode.git
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (add-to-list 'load-path  (expand-file-name "site-lisp/maven-pom-mode" user-emacs-directory)) ;;
;; (add-to-list 'auto-mode-alist '("pom.xml" . maven-pom-mode))                                 ;;
;; (load "maven-pom-mode")                                                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;==========maven pom end==========

(use-package mvn
  :ensure t
  )

(defun mvn-install ()
  (interactive)
  (mvn "install"))

;;(add-to-list 'auto-mode-alist '("\\.properties\\'" . lsp-java-boot-lens-mode))


;; https://github.com/juergenhoetzel/emacs-nexus.git
;; (add-to-list 'load-path  (expand-file-name "site-lisp/emacs-nexus" user-emacs-directory))
;; (require 'nexus)
;; (setq nexus-rest-url "https://nexus.peoplecommnue.com/nexus/service/local/lucene/search")
;; (require 'ac-nexus)
;; (add-hook 'clojure-mode-hook 'ac-source-lein-set-up)
;; (setq mm-url-use-external t)
(provide 'init-lsp-java)
