;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ivy, counsel and swiper. Mostly minibuffer and navigation
;; enhancements. Using smex for last recently used sorting.;; ivy, counsel and swiper. Mostly minibuffer and navigation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 ;; 使用了这个smex 就可以实现M-x 默认值为最新输入的command recent command
(use-package smex) 

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


(provide 'init-minibuffer-tool)
