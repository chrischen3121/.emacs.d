;;; cc-org-roam.el --- Configuration for org-roam

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

;;; Hints:

;; TODO: try mathpix.el and winner-mode

;;; Code:

(defcustom cc-org-roam/org-roam-directory "~/second-brain/pages"
  "org roam home directory"
  :type 'string
  :group 'cc-org-roam)


(defcustom cc-org-roam/org-roam-dailies-directory "~/second-brain/journals"
  "org roam dailies directory"
  :type 'string
  :group 'cc-org-roam)

(defcustom cc-org-roam/org-roam-db-location "~/second-brain/org-roam.db"
  "org roam db directory"
  :type 'string
  :group 'cc-org-roam)

(defcustom cc-org-roam/org-roam-graph-viewer "google-chrome-stable"
  "executable to view org roam graph"
  :type 'string
  :group 'cc-org-roam)

(use-package
  org-roam
  :init (setq org-roam-v2-ack t)
  (which-key-add-key-based-replacements "C-c n" "org-roam")
  :ensure t
  :delight
  :custom (org-roam-directory cc-org-roam/org-roam-directory)
  (org-roam-db-location cc-org-roam/org-roam-db-location)
  (org-roam-graph-viewer cc-org-roam/org-roam-graph-viewer)
  (org-roam-dailies-directory cc-org-roam/org-roam-dailies-directory)
  (org-roam-completion-everywhere t)
  (org-roam-capture-templates '(("d" "default" plain "%?"
                                 :immediate-finish t
                                 :if-new (file+head "${slug}.org" "#+TITLE: ${title}\n")
                                 :unnarrowed t)
                                ("t" "temp" plain "%?"
                                 :immediate-finish t
                                 :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                                                    "#+TITLE: ${title}\n")
                                 :unnarrowed t)))
  (add-to-list 'display-buffer-alist '("\\*org-roam\\*" (display-buffer-in-side-window)
                                       (side . right)
                                       (slot . 0)
                                       (window-width . 0.33)
                                       (window-parameters . ((no-other-window . t)
                                                             (no-delete-other-windows . t)))))
  :config (org-roam-db-autosync-mode)
  (setq org-id-extra-files (org-roam--list-files org-roam-directory))
  (require 'org-roam-protocol)
  :bind (("C-c n j" . org-roam-dailies-goto-today)
         ("C-c n d" . org-roam-dailies-find-directory)
         ("C-c n c" . org-roam-capture)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n p" . org-id-get-create)
         ("C-c n u" . org-roam-ui-mode)
         ("C-c n w" . org-roam-migrate-wizard)
         :map org-mode-map ("C-c n a" . org-roam-alias-add)
         ("C-c n b" . org-roam-buffer-toggle)
         ("C-c n t" . org-roam-tag-add)
         ("C-c n r" . org-roam-ref-add)
         ("C-c n n" . org-roam-node-random)
         ("C-c n g" . org-roam-graph)))

;; full-text search
;; C-c C-g refresh the file browser
;; C-c C-c to clear the filter string
(use-package
  deft
  :after org
  :bind ("C-c n s" . deft)
  :custom (deft-recursive t)
  ;; For creating files
  ;; (deft-use-filename-as-title t)
  ;; (deft-use-filter-string-for-filename t)
  (deft-default-extension "org")
  (deft-directory cc-org-roam/org-roam-directory))

(use-package
  org-roam-ui
  :after org-roam
  :custom (org-roam-ui-sync-theme t)
  (org-roam-ui-follow t)
  (org-roam-ui-update-on-save t)
  :delight)


(provide 'cc-org-roam)

;;; cc-org-roam.el ends here
