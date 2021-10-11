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


(setq org-agenda-dir (expand-file-name "~/Desktop/note/gtd/"))
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


(provide 'init-org)
