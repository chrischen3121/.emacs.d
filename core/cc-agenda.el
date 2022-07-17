;;; cc-agenda.el --- Configuration for org agenda

;; Author: chrischen
;; Maintainer: chrischen

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

;;; Commentary:
;;

;;; Useful Commands:
;; I -- org-agenda-clock-in
;; O -- org-agenda-clock-out
;; X -- org-agenda-clock-cancel
;; J -- org-agenda-clock-goto
;; e -- org-agenda-set-effort
;; l -- Logbook mode

;;; Hints
;; Subtasks progress: type [/] [%], then C-c C-c
;; Example:
;; * Project A [33%]
;; ** TODO Task1 [1/2]
;; - [X] sub task1
;; - [ ] sub task2
;; ** DONE Task2
;; ** TODO Task3

;;; Code:


(defcustom cc-agenda/agenda-home-dir "~/TODOs"
  "agenda home directory"
  :type 'string
  :group 'cc-agenda)

(defun cc-agenda/setup-keywords ()
  (setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "HOLD(h@)"  "|" "DONE(d)" "CANCELED(c)")
                            (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")))
  (setq org-todo-keyword-faces '(("TODO" . "salmon")
                                 ("NEXT" . "light blue")
                                 ("HOLD" . "medium purple")
                                 ("DONE" . "light green")
                                 ("CANCELED" .  "gray")
                                 ("REPORT" .  "medium purple")
                                 ("BUG" .  "salmon")
                                 ("KNOWNCAUSE" .  "light blue")
                                 ("FIXED" . "light green")))
  (setq org-todo-state-tags-triggers '(("HOLD" ("NEXT")
                                        ("HOLD" . t))
                                       ("NEXT" ("HOLD")
                                        ("NEXT" . t))
                                       ("DONE" ("HOLD")
                                        ("NEXT"))
                                       ("TODO" ("NEXT")
                                        ("HOLD"))))
  (setq org-agenda-custom-commands '(("H" todo "HOLD")
                                     ("N" todo "NEXT")
                                     ("D" todo "DONE")
                                     ("R" todo "REPORT")
                                     ("G" todo "BUG")
                                     ("F" todo "FIXED")
                                     ("c" tags-todo "Child")
                                     ("w" tags "Work"))))

(use-package
  org-superstar
  :custom (org-superstar-todo-bullet-alist '(("TODO" . ?⬜)
                                             ("CANCELED" . ?✘)
                                             ("DONE" . ?✔)
                                             ("NEXT" . ?↦)
                                             ("HOLD" . ?☎)
                                             ("REPORT" . ?✋)
                                             ("BUG" . ?⚠)
                                             ("KNOWNCAUSE" . ?⭗)
                                             ("FIXED" . ?✔))))

(use-package
  emacs
  :custom ((org-agenda-files (directory-files-recursively cc-agenda/agenda-home-dir ".org$"))
           (org-default-notes-file (expand-file-name "captured.org" cc-agenda/agenda-home-dir))
           (org-export-with-todo-keywords nil))
  :hook (after-init . cc-agenda/setup-keywords))


(use-package
  org-agenda
  :ensure nil
  :after org
  :custom ((org-deadline-warning-days 3)
           (org-clock-out-remove-zero-time-clocks t)
           (org-clock-out-when-done t)
           (org-refile-targets '((nil :level . 1)
                                 (org-agenda-files :level . 1)))
           (org-columns-default-format
            "%40ITEM(Task) %TODO %3PRIORITY %17Effort(Effort){:} %10CLOCKSUM")
           (org-capture-templates '(("t" "Todo" entry (file+headline org-default-notes-file "Tasks")
                                     "* TODO %?\n %U\n")))
           (org-tag-alist '(("Work" . ?w)
                            ("Learning" . ?l)
                            ("Hobby" . ?h)
                            ("Housekeeping" . ?k)
                            ("English" . ?e)
                            ("Child" . ?c)
                            ("CS" . ?s)
                            ("Finance" . ?f)
                            ("Routine" . ?r)
                            ("CPP" . ?+)
                            ("Python" . ?p)
                            ("Math" . ?m)
                            ("Frontend" . ?F)
                            ("Backend" . ?b)
                            ("Database" . ?d)
                            ("ML" . ?M)
                            ("Project" . ?P)
                            ("Coursera" . ?C)
                            ("Geekbang" . ?G)
                            ("Udacity" . ?U))))
  :bind (("C-c a" . org-agenda)
         ("C-c c" . org-capture)
         :map org-mode-map ("C-c a r" . org-archive-subtree-default)
         ("C-c a a" . org-agenda)
         ("C-c a i" . org-clock-in)
         ("C-c a o" . org-clock-out)
         ("C-c a e" . org-clock-modify-effort-estimate)
         ("C-c a q" . org-clock-cancel)
         ("C-c a j" . org-clock-goto)
         :map org-agenda-mode-map ("C" . org-agenda-columns)))

(use-package
  org-super-agenda
  :custom (org-super-agenda-groups
           '((:name "Next"
                    :time-grid t
                    :todo "NEXT")
             (:name "Important"
                    :todo "BUG"
                    :priority "A")
             (:name "Deadline"
                    :deadline t)
             (:name "Learning"
                    :tag ("English" "Learning")
                    :not (:priority "C"))
             (:name "MOOC"
                    :tag ("Coursera" "Udacity" "Geekbang")
                    :not (:priority "C"))
             (:name "Luke"
                    :tag "Child")
             (:name "Project"
                    :tag "Project")
             (:name "Work"
                    :tag "Work")
             (:todo "HOLD")
             (:priority<= "C")))
  :hook (org-agenda-mode . org-super-agenda-mode))

(provide 'cc-agenda)

;;; cc-agenda.el ends here
