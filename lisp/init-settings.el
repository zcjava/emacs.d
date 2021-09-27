;; ;; Adjust garbage collection thresholds during startup, and thereafter
;; (let ((normal-gc-cons-threshold (* 20 1024 1024))
;;       (init-gc-cons-threshold (* 128 1024 1024)))
;;   (setq gc-cons-threshold init-gc-cons-threshold)
;;   (add-hook 'emacs-startup-hook
;;             (lambda () (setq gc-cons-threshold normal-gc-cons-threshold))))

;;(setq gc-cons-threshold (* 128 1024 1024))
(setq gc-cons-percentage 0.6)
(setq gc-cons-threshold most-positive-fixnum)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;;==========utf8==========
;; 设置emacs 使用 utf-8
;; 设置为中文简体语言环境
;; (setenv "LANG" "zh_CN.UTF-8")
(set-language-environment "UTF-8")
;; (setq locale-coding-system 'utf-8)
;; ;; 设置键盘输入时的字符编码
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
;; ;; 文件默认保存为 utf-8
(set-buffer-file-coding-system 'utf-8)
(set-default buffer-file-coding-system 'utf8)
(set-default-coding-systems 'utf-8)
;; ;; 解决粘贴中文出现乱码的问题
(set-clipboard-coding-system 'utf-8)
;; ;; 终端中文乱码
(set-terminal-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; 下面这个设置会让lsp-java-sprint-boot code completion出现问题 ;;
;; ;;(setq default-process-coding-system '(utf-8 . utf-8)) ;;      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; 解决文件目录的中文名乱码
(setq-default pathname-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
;;==========utf8 end==========


;;==========tab indent==========
(use-package smart-tabs-mode)
(setq tab-width 4)
(setq-default tab-width 4)
(smart-tabs-insinuate 'c 'c++ 'java 'javascript 'cperl 'python 'ruby 'nxml)
(setq c-basic-offset 4)
;; (setq tab-always-indent)
(setq-default indent-tabs-mode nil)
;; nxml-mode
(setq
 nxml-child-indent 4
 nxml-attribute-indent 4
 nxml-slash-auto-complete-flag t)

;;==========tab indent end==========


(setq auto-save-default nil)
;;不保留备份文件  eg:  init.el~之类的文件
(setq make-backup-files nil)
;; 使用y/n 替代yes/no
(fset 'yes-or-no-p 'y-or-n-p)
;; unless 的含义是 if nil  do body
(delete-selection-mode t)
;;=========加载系统环境变量==========
(use-package exec-path-from-shell
  :ensure t
  ;;  :config (setq exec-path (append exec-path '("/usr/local/bin")))
  )
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(setq exec-path-from-shell-check-startup-files nil)


(provide 'init-settings)
