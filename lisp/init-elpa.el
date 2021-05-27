(setq package-archives '(
 			             ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
 			             ("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
 			             ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))
;;(setq package-archives '(
;;                         ("gnu" . "https://elpa.gnu.org/packages/")
;;                         ("melpa" . "https://melpa.org/packages/")
;;                         ("org" . "https://orgmode.org/elpa/")
;;                         ("melpa-stable" . "https://stable.melpa.org/packages/")))

;; (setq url-proxy-services
;;         '(("no_proxy" . "^\\(localhost\\|10.*\\)")
;;           ("http" . "127.0.0.1:52067")
;;           ("https" . "127.0.0.1:52067")))

;;(add-to-list 'package-archives
;;	     '("melpa" . "http://elpa.emacs-china.org/melpa/"))

(unless (bound-and-true-p package--initialized)
  (package-initialize)) ;; 刷新软件源索引

(provide 'init-elpa)

