;;; cc-agenda.el

;; Author: auther
;; Maintainer: auther

;; This file is not part of GNU Emacs

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;;; Code:

(defcustom cc-agenda/agenda-home-dir "~/TODOs"
  "agenda home directory"
  :type 'string
  :group 'cc-agenda)


(setq org-agenda-files (directory-files-recursively cc-agenda/agenda-home-dir ".org$"))
(setq org-default-notes-file (expand-file-name "refile.org" cc-agenda/agenda-home-dir))
(setq org-capture-templates '(("t" "todo" entry (file org-default-notes-file) "* TODO %?\n%U\n%a\n"
                               :clock-in t
                               :clock-resume t)))

(setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
                          (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")))
(setq-default org-priority-default 67)

(setq org-todo-state-tags-triggers '(("CANCELED" ("CANCELED" . t))
                                     ("WAITING" ("WAITING" . t))
                                     ("HOLD" ("WAITING")
                                      ("HOLD" . t))
                                     ("DONE" ("WAITING")
                                      ("CANCELED")
                                      ("HOLD"))
                                     ("TODO" ("WAITING")
                                      ("CANCELED")
                                      ("HOLD"))
                                     ("NEXT" ("WAITING")
                                      ("CANCELED")
                                      ("HOLD"))))

(setq org-todo-keyword-faces '(("TODO" . "red")
                               ("NEXT" . "blue")
                               ("WAITING" . "orange")
                               ("HOLD" . "purple")
                               ("DONE" . "forest green")
                               ("CANCELED" .  "forest green")))
(setq-default org-export-with-todo-keywords nil)

;; (use-package
;;   org-superstar
;;   :custom (org-superstar-special-todo-items t)
;;   (org-superstar-todo-bullet-alist '(("TODO" . ?☐)
;;                                      ("NEXT" . ?✒)
;;                                      ("HOLD" . ?✰)
;;                                      ("WAITING" . ?☕)
;;                                      ("CANCELLED" . ?✘)
;;                                      ("DONE" . ?✔)))
;;   :hook (org-mode . org-superstar-mode))


(setq org-refile-targets '((nil :maxlevel . 2)
                           (org-agenda-files :maxlevel . 2)))

;; which-key
(which-key-add-key-based-replacements "C-c g" "agenda")

(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c g a") 'org-agenda)
(global-set-key (kbd "C-c g c") 'calendar)
(global-set-key (kbd "C-c g g") 'gnus)
(global-set-key (kbd "C-c g i") 'org-clock-in)
(global-set-key (kbd "C-c g o") 'org-clock-out)
(global-set-key (kbd "C-c g v") 'visible-mode)

(use-package
  org-agenda
  :ensure nil
  :after org
  :custom
  ;; org-clock
  (org-clock-out-remove-zero-time-clocks t)
  (org-clock-in-resume t)
  (org-clock-out-when-done t)
  (org-clock-persist t)
  (org-clock-report-include-clocking-task t)
  ;; schedule
  (org-deadline-warning-days 3)
  ;; column view
  (org-columns-default-format "%40ITEM(Task) %TODO %3PRIORITY %17Effort(Effort){:} %10CLOCKSUM")
  (org-global-properties '(("Effort_ALL" . "0:15 0:30 0:45 1:00 2:00 3:00 4:00 5:00 6:00 0:00"))
                         (org-agenda-clockreport-parameter-plist
                          '(:link t
                                  :maxlevel 5
                                  :fileskip0 t
                                  :compact t
                                  :narrow 80)))
  :bind (:map org-agenda-mode-map
              ("C-c i" . org-agenda-clock-in)
              ("C-c o" . org-agenda-clock-out)
              ("C-c v" . org-agenda-columns)
              ("C-c e" . org-agenda-set-effort)))

(provide 'cc-agenda)

;;; cc-agenda.el ends here
