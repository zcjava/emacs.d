(setq inhibit-startup-message t)

(require 'package)
(setq package-enable-at-startup nil)
(setq use-package-always-ensure t)
;;(add-to-list 'package-archives



;;	     '("melpa" . "http://elpa.emacs-china.org/melpa/"))
;; (setq package-archives '(
;; 			             ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
;; 			             ("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;; 			             ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))
(setq package-archives '(
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")))
;; (setq url-proxy-services
;;         '(("no_proxy" . "^\\(localhost\\|10.*\\)")
;;           ("http" . "127.0.0.1:52067")
;;           ("https" . "127.0.0.1:52067")))
(package-initialize)

;;隐藏菜单栏
(menu-bar-mode nil)
;;隐藏工具栏
;;(tool-bar-mode nil)
(tool-bar-mode -1)
;;隐藏滚动条
(scroll-bar-mode nil)


;;设置默认目录
(setq default-directory "~/")

;;==========utf8==========
;; 设置emacs 使用 utf-8
;; 设置为中文简体语言环境
(setenv "LANG" "zh_CN.UTF-8")
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
;;;; 设置编辑环境



;; 解决 Shell Mode(cmd) 下中文乱码问题
;;==========utf8 end==========
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; White space
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;==========tab indent==========
(setq tab-width 4)
(setq-default tab-width 4)
(setq c-basic-offset 4)
;; (setq tab-always-indent)
(setq-default indent-tabs-mode nil)
;;==========tab indent end==========


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

;;==========mode line 美化显示==========
(use-package nyan-mode
  :ensure t
  :init
  (setq nyan-animate-nyancat t)
  (setq nyan-wavy-trail t)
  (setq nyan-minimum-window-width 80)
  (setq nyan-bar-length 20)
  (nyan-mode))


(use-package doom-modeline
  :ensure t
  :config
  (doom-modeline-def-modeline 'ownml
    '(bar matches buffer-info remote-host buffer-position misc-info major-mode) 
    '(input-method buffer-encoding process vcs checker))

  ;; Add to `doom-modeline-mode-hook` or other hooks
  (defun setup-custom-doom-modeline ()
    (doom-modeline-set-modeline 'ownml 'default))
  (add-hook 'doom-modeline-mode-hook 'setup-custom-doom-modeline)
  )


(doom-modeline-mode t)
;;==========mode line 美化显示 end==========


(use-package leetcode
  :config
  (setq leetcode-prefer-language "java")
  (setq leetcode-prefer-sql "mysql")
  (setq leetcode-save-solutions t)
  (setq leetcode-directory (expand-file-name "~/Desktop/note/leetcode/"))
  )

(use-package hungry-delete
  :ensure t
  :bind (
	     ("C-c DEL" . hungry-delete-backward)
	     ("C-c d" . hungry-delete-forward))
  )


;;命令补全列表
(use-package which-key
  :ensure t  ;;是否一定要确保已安装
  :bind ("M-m" . which-key-show-top-level)  ;; 绑定超级键，顶层命令列表
  )
(which-key-mode)


;;==========skybert==========
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Show paren mode, built-in from Emacs 24.x   光标悬停代码块加底色
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(show-paren-mode t)
(setq show-paren-style 'expression)

(use-package paren)
(set-face-background 'show-paren-match (face-background 'default))
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

;; Sub word support
(add-hook 'minibuffer-setup-hook 'subword-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;skybert;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ws-butler cleans up whitespace only on the lines you've edited,
;; keeping messy colleagues happy ;-) Important that it doesn't clean
;; the whitespace on currrent line, otherwise, eclim leaves messy
;; code behind.
(use-package ws-butler
  :init
  (setq ws-butler-keep-whitespace-before-point nil)
  :config
  (ws-butler-global-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ivy, counsel and swiper. Mostly minibuffer and navigation
;; enhancements. Using smex for last recently used sorting.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package smex)  ;; 使用了这个smex 就可以实现M-x 默认值为最新输入的command recent command

(use-package ivy
  :init
  (setq ivy-height 20
        ;;ivy-initial-inputs-alist nil
        ))

(use-package ivy-posframe
  :init
  (setq ivy-posframe-display-functions-alist
        '((complete-symbol . ivy-posframe-display-at-point)
          (counsel-M-x     . ivy-posframe-display-at-frame-center)
          (t               . ivy-posframe-display-at-frame-center)))
  (ivy-posframe-mode 0))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind
  ("C-."   . 'counsel-imenu)
  ("C-c '" . 'counsel-git-grep)
  ("C-c ," . 'counsel-imenu)
  ("C-h f" . 'counsel-describe-function)
  ("C-h v" . 'counsel-describe-variable)
  ("C-o"   . 'counsel-outline)
  ("C-x b" . 'counsel-switch-buffer)
  ("C-x g" . 'counsel-rg)

  :hook (after-init . ivy-mode)
  )

;; (use-package counsel
;;   :ensure t
;;   ;;  :config (require 'swiper) (require 'counsel) ;; 依赖
;;   :hook (after-init . ivy-mode)
;;   )




;;(global-set-key (kbd "C-s") 'isearch-forward)
(global-set-key (kbd "C-'") 'swiper-isearch-thing-at-point)

(use-package counsel-projectile
  :bind
  ("C-c p f" . 'counsel-projectile-find-file)
  ("C-c p g" . 'counsel-projectile-rg)
  ("C-c p p" . 'counsel-projectile-switch-project)
  ("C-c p b" . 'counsel-projectile-switch-to-buffer)
  )

;;==========skybert==========



;;==========flycheck==========
(use-package flycheck
  :init (global-flycheck-mode)
  :ensure t
  )
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
;;==========flycheck==========

;; org 漂亮排版
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook #'org-bullets-mode)
  (add-hook 'org-mode-hook #'org-indent-mode)
  )

(setq org-startzup-folded nil)

;; (add-to-list 'org-agenda-custom-commands
;;                    '("r" "Daily Agenda Review"
;;                      ((agenda "" ((org-agenda-overriding-header "今日记录")
;;                                   (org-agenda-span 'day)
;;                                   (org-agenda-show-log 'clockcheck)
;;                                   (org-agenda-start-with-log-mode nil)
;;                                   (org-agenda-log-mode-items '(closed clock state))
;;                                   (org-agenda-clockreport-mode t))))))

;;==========org-agenda==========

(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c l") 'org-store-link)


(setq org-agenda-dir (expand-file-name "~/Desktop/note/"))
(setq org-agenda-file-inbox (concat org-agenda-dir "inbox.org"))
(setq org-agenda-file-gtd (concat org-agenda-dir "gtd.org"))
(setq org-agenda-file-tickler (concat org-agenda-dir "tickler.org"))
(setq org-agenda-file-someday (concat org-agenda-dir "someday.org"))
(setq org-agenda-files (list org-agenda-dir))

(setq org-capture-templates `(
                              ("t" "Todo [inbox]" entry (file+headline ,org-agenda-file-inbox "Tasks") "* TODO %i%?")
                              ("T" "Ticker" entry (file+headline ,org-agenda-file-tickler "Tickler") "* %i%? \n %U")
                              ))

(setq org-refile-targets `((,org-agenda-file-gtd :maxlevel . 3)
                           (,org-agenda-file-someday :level . 1)
                           (,org-agenda-file-tickler :maxlevel . 2)))

(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

(setq org-log-done 'time)
;; 如果子任务完成，则父任务自动完成
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

;; Change task state to STARTED when clocking in
;;(setq org-clock-in-switch-to-state "TODO")
;;(setq org-clock-out-switch-to-state "DONE")


;; tags
(setq org-tag-alist '(("@work" . ?w) ("@home" . ?h)
                      ("@study" . ?s)))


;; pomodoro 通知功能
(defun notify-osx (title message)
  (call-process "terminal-notifier"
                nil 0 nil
                "-group" "Emacs"
                "-title" title
                "-message" message
                ;;"-sender" "org.gnu.Emacs"
                "-activate" "oeg.gnu.Emacs"))

;; 任务提醒功能
;; https://emacs-china.org/t/org-agenda/232
(use-package org-alert
  )

(require 'appt)
(setq appt-time-msg-list nil)    ;; clear existing appt list
(setq appt-display-interval '10)  ;; warn every 5 minutes from t - appt-message-warning-time
(setq
 appt-message-warning-time '20  ;; send first warning 15 minutes before appointment
 appt-display-mode-line nil     ;; don't show in the modeline
 appt-display-format 'window)   ;; pass warnings to the designated window function
(appt-activate 1)                ;; activate appointment notification
(display-time)                   ;; activate time display

(org-agenda-to-appt)             ;; generate the appt list from org agenda files on emacs launch
(run-at-time "24:01" 3600 'org-agenda-to-appt)           ;; update appt list hourly
(add-hook 'org-finalize-agenda-hook 'org-agenda-to-appt) ;; update appt list on agenda view
(defun my-appt-display (min-to-app new-time msg)
  (notify-osx
   (format "Appointment in %s minutes" min-to-app)    ;; passed to -title in terminal-notifier call
   (format "%s" msg)))                                ;; passed to -message in terminal-notifier call
(setq appt-disp-window-function (function my-appt-display))
(use-package org-super-agenda

  )
;;==========org-agenda end==========

;;==========org pomodoro==========
(use-package org-pomodoro
  )
;;==========org pomodoro==========


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

;;==========vterm==========
;; 需要安装cmake、libtool.使用brew install cmake , libtool
(use-package vterm
  :ensure t
  )


(use-package treemacs
  :ensure t
  :commands (treemacs)
  :after (lsp-mode))

;;(treemacs)



(use-package projectile
  ;; :bind
  ;; ("C-c p f" . projectile-find-file)
  ;; ("C-c p g" . projectile-grep)
  ;; :init
  ;; (setq projectile-enable-caching t
  ;;       projectile-globally-ignored-file-suffixes
  ;;       '(
  ;;         "blob"
  ;;         "class"
  ;;         "classpath"
  ;;         "gz"
  ;;         "iml"
  ;;         "ipr"
  ;;         "jar"
  ;;         "pyc"
  ;;         "tkj"
  ;;         "war"
  ;;         "xd"
  ;;         "zip"
  ;;         )
  ;;       projectile-globally-ignored-files '("TAGS" "*~")
  ;;       projectile-tags-command "/usr/bin/ctags -Re -f \"%s\" %s"
  ;;       projectile-mode-line '(:eval (format " [%s]" (projectile-project-name)))
  ;;       )
  :config
  (projectile-global-mode)

  
  ;; 注意rg会忽略gitignore的文件，所以如果需要unignore某些在gitignore的文件：需要设置(setq projectile-indexing-method 'native)
  ;; counsel-projectile-rg 忽略不忽略由 .gitginore + .ignore(.ignore优先级高于.gitignore)共同决定；
  ;; counsel-projectile-find-file 忽略不忽略由 .projectile 决定
  (setq projectile-indexing-method 'native)

  (setq projectile-globally-ignored-directories
        (append (list
                 ".pytest_cache"
                 "__pycache__"
                 "build"
                 "elpa"
                 "node_modules"
                 "output"
                 "reveal.js"
                 "semanticdb"
                 "target"
                 "venv"
                 )
                projectile-globally-ignored-directories))
  )



;; (use-package projectile
;;   :config
;;   (projectile-mode)
;;   (setq projectile-completion-system 'ivy)
;;   :bind
;;   ("C-c p f" . projectile-find-file)
;;   ("C-c p g" . projectile-grep)
;;   )

(use-package treemacs-projectile)

(use-package yasnippet
  :config (yas-global-mode)
  (use-package yasnippet-snippets :ensure t)
  )

(add-hook 'prog-mode-hook 'hs-minor-mode)


;;==========java==========



(use-package lsp-mode
  :ensure t
  :hook (
         (lsp-mode . lsp-enable-which-key-integration)
         (java-mode . #'lsp-deferred))
  :commands lsp
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
  (setq
   ;; 关闭lsp debug信息
   ;; lsp-inhibit-message t
   lsp-eldoc-render-all nil
   lsp-enable-file-watchers nil
   lsp-enable-symbol-highlighting nil
   lsp-headerline-breadcrumb-enable nil
   lsp-highlight-symbol-at-point nil
   lsp-modeline-code-actions-enable nil
   lsp-modeline-diagnostics-enable nil
   )

  ;; Performance tweaks, see
  ;; https://github.com/emacs-lsp/lsp-mode#performance
  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 1024 1024)) ;; 1mb
  (setq lsp-idle-delay 0.500)
  )

(use-package groovy-mode)
;;(require 'lsp-groovy)
;;(add-hook 'groovy-mode-hook #'lsp-groovy-enable)

;; (use-package lsp-mode
;;   :hook ((lsp-mode . lsp-enable-which-key-integration))
;;   :config (setq lsp-completion-enable-additional-text-edit nil)
;;   :commands lsp
;;   )


;; (use-package company-lsp
;;   :ensure t)


(use-package lsp-ui
  :after lsp-mode
  :init
  (setq lsp-ui-doc-enable nil)
  :config
  (setq lsp-prefer-flymake nil
        lsp-ui-doc-delay 5.0
;;        lsp-ui-imenu-auto-refresh t
   ;;     lsp-ui-imenu--custom-mode-line-format t
        lsp-ui-sideline-enable nil
        lsp-ui-sideline-show-symbol nil)
  )

(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user

(use-package helm-descbinds
  :ensure t
  :bind ("C-h b" . helm-descbinds)
  )

(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)

(use-package lsp-java
  :init
  (setq lsp-java-server-install-dir (expand-file-name "~/.emacs.d/emacs-lsp-java/lsp-java-server/"))
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
  (setq lsp-groovy-server-file (expand-file-name "~/.emacs.d/emacs-lsp-java/groovy-language-server/groovy-language-server-all.jar"))
  (setq lsp-java-configuration-maven-user-settings (expand-file-name "~/.m2/settings.xml"))
  (setq lsp-java-maven-download-sources t)
  (setq lsp-java-import-maven-enabled t)
  (setq lsp-java-references-code-lens-enabled t)
  (setq lsp-java-autobuild-enabled t)
  ;;  (setq lsp-java-save-actions-organize-imports t)
  :config
  (setq lsp-java-format-settings-url "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml" lsp-java-format-settings-profile "GoogleStyle")
  (setq lsp-java-format-enabled t)
  (setq lsp-java-format-comments-enabled t)
;;  (setq lsp-java-configuration-check-project-settings-exclusions t)
  (add-hook 'java-mode-hook 'lsp)
  (add-hook 'before-save-hook 'lsp-format-buffer)
;;  (add-hook 'before-save-hook 'lsp-java-format)
  )

(use-package dap-mode
  :init
  ;;  (setq dap-java-test-additional-args '("-n" "\".*(Test|IT).*\""))
  (setq dap-java-java-command "/usr/local/opt/openjdk@11/bin/java")
  :ensure t
  :after lsp-mode
  :functions dap-hydra/nil
  :bind (:map lsp-mode-map
              ("<f5>" . dap-debug)
              ("M-<f5>" . dap-hydra))
  :hook ((dap-mode . dap-ui-mode)
         (dap-session-created . (lambda (&_rest) (dap-hydra)))
         (dap-terminated . (lambda (&_rest) (dap-hydra/nil))))
  :config
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

(use-package yaml-mode)


(use-package lsp-treemacs
;;  :config
;;  (lsp-treemacs-sync-mode t)
  :after (lsp-mode treemacs)
  :config
  (global-set-key (kbd "M-s-.") 'lsp-treemacs-implementations)
  :ensure t
  :commands lsp-treemacs-errors-list
  :bind (:map lsp-mode-map
              ("M-9" . lsp-treemacs-errors-list)))

;;(use-package gradle-mode
;;  )

(use-package yaml-mode)
;;==========java end==========


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
  (setq lsp-pyright-extra-paths (list"/usr/local/lib/python3.9/site-packages/" "."))
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp))))  ; or lsp-deferred

(use-package flycheck-pyflakes
  )
;;==========python end==========

;; 针对maven的pom和其他的xml 标签补全
(add-to-list 'auto-mode-alist '("\\.\\(xml\\|xsl\\|rng\\|xhtml\\|lzx\\|x3d\\)\\'" . nxml-mode))
(setq rng-schema-locating-files (list (expand-file-name "~/.emacs.d/schema/schemas.xml")))

;; git clone https://github.com/m0smith/maven-pom-mode.git ~/.emacs.d/elpa/
(add-to-list 'load-path  (expand-file-name "~/.emacs.d/elpa/maven-pom-mode"))
(load "maven-pom-mode")
(add-to-list 'auto-mode-alist '("pom.xml" . maven-pom-mode))
;;==========xml处理==========

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
(exec-path-from-shell-initialize)
(setq exec-path-from-shell-check-startup-files nil)
;;(when (memq window-system '(mac ns x))



(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
;;(global-set-key (kbd "C-x C-f") 'counsel-find-file)
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

(global-set-key (kbd "C-c z") 'zoom)
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

;;==========maven pom snippets==========
;; (use-package maven-pom-mode
;;   :load-path (lambda () (expand-file-name "~/.emacs.d/elpa/maven-pom-mode/"))
;;   :config
;;   (awesome-tab-mode t)
;;   )
;;==========maven pom snippets end==========


(defun my/ansi-colorize-buffer ()
  (let ((buffer-read-only nil))
    (ansi-color-apply-on-region (point-min) (point-max))))

(defun display-ansi-colors ()
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))

(use-package ansi-color
  :ensure t
  :config
  (add-hook 'compilation-filter-hook 'my/ansi-colorize-buffer)
  )

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

(use-package quickrun
  :ensure t
  :bind ("C-c r" . quickrun))

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

;;==========myself custom fun==========
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el")
  )

(global-set-key (kbd "<C-return>") 'newline-code-tab)

(defun newline-code-tab()
  (interactive)
  (newline-and-indent)
  (newline-and-indent)
  (previous-line)
  (indent-for-tab-command)
  )


(defun copy-path()
  (interactive)
  (setq currentdir default-directory)
  (message "%s" currentdir)
  (x-select-text currentdir)
  )
;;==========myself custom==========

;;字体设置
;;(set-face-attribute 'default nil :font "Menlo-16")
(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-16"))
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(use-package magit lsp-ui company-lsp multiple-cursors sqlite3 helm-dash undo-tree leetcode org-alert org-pomodoro vue-mode vagrant-tramp youdao-dictionary yaml-mode json-mode lsp-pyright gradle-mode lsp-groovy groovy-mode java-snippets smex dumb-jump window-number treemacs-projectile awesome-tab zoom window-numbering pdf-tools yasnippet which-key org-bullets mvn lsp-java lsp-ivy hungry-delete helm-lsp format-all flycheck exec-path-from-shell dracula-theme counsel company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
