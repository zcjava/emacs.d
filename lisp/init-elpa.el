;; (setq package-archives '(
;;  			             ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
;;  			             ("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;;  			             ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))
(setq package-archives '(
                        ("gnu" . "https://elpa.gnu.org/packages/")
                        ("melpa" . "https://melpa.org/packages/")
                        ("org" . "https://orgmode.org/elpa/")
                        ("melpa-stable" . "https://stable.melpa.org/packages/")))

(setq url-proxy-services
        '(("no_proxy" . "^\\(localhost\\|10.*\\)")
          ("http" . "127.0.0.1:52730")
          ("https" . "127.0.0.1:52730")))

(unless (bound-and-true-p package--initialized)
  (package-initialize)) ;; 刷新软件源索引

(unless package-archive-contents
  (package-refresh-contents))
;; 当没有安装包，则执行刷新package并安装package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'package)
(setq package-enable-at-startup nil)
(setq use-package-always-ensure t)

;; (eval-and-compile
;;     (setq use-package-always-ensure t) ;不用每个包都手动添加:ensure t关键字
;;     (setq use-package-always-defer t) ;默认都是延迟加载，不用每个包都手动添加:defer t
;;     )

(provide 'init-elpa)

