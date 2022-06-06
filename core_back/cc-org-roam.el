;;; cc-org-roam.el

;; Author: Chris Chen
;; Maintainer: Chris Chen

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

(defcustom cc-org-roam/org-roam-directory "~/roam-notes/permanent"
  "org roam home directory"
  :type 'string
  :group 'cc-org-roam)

(defcustom cc-org-roam/org-roam-dailies-directory "~/roam-notes/fleeting"
  "org roam dailies directory"
  :type 'string
  :group 'cc-org-roam)

(defcustom cc-org-roam/org-roam-db-location "~/roam-notes/org-roam.db"
  "org roam db directory"
  :type 'string
  :group 'cc-org-roam)

(defcustom cc-org-roam/org-roam-graph-viewer "google-chrome"
  "executable to view org roam graph"
  :type 'string
  :group 'cc-org-roam)

(use-package
  org-roam
  :init (setq org-roam-v2-ack t)
  :ensure t
  :delight
  :custom (org-roam-directory cc-org-roam/org-roam-directory)
  (org-roam-db-location cc-org-roam/org-roam-db-location)
  (org-roam-graph-viewer cc-org-roam/org-roam-graph-viewer)
  (org-roam-dailies-directory cc-org-roam/org-roam-dailies-directory)
  (org-id-link-to-org-use-id t)
  (org-roam-capture-templates '(("d" "default" plain "%?"
                                 :immediate-finish t
                                 :if-new (file+head "${slug}.org" "#+TITLE: ${title}\n")
                                 :unnarrowed t)
                                ("t" "temp" plain "%?"
                                 :immediate-finish t
                                 :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                                                    "#+TITLE: ${title}\n")
                                 :unnarrowed t)))
  :config (org-roam-db-autosync-mode)
  (setq org-id-extra-files (org-roam--list-files org-roam-directory))
  (require 'org-roam-protocol)
  ;; (setq org-roam-completion-system 'ivy)
  :bind (("C-c n j" . org-roam-dailies-capture-today)
         ("C-c n d" . org-roam-dailies-find-directory)
         ("C-c n c" . org-roam-capture)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n p" . org-id-get-create)
         ("C-c n b" . org-roam-buffer-toggle)
         ("C-c n s" . org-roam-ui-mode)
         :map org-mode-map ("C-c n a" . org-roam-alias-add)
         ("C-c n t" . org-roam-tag-add)
         ("C-c n r" . org-roam-ref-add)))

;; org-roam-ui
(use-package
  simple-httpd)

(use-package
  websocket
  :after org-roam)

(use-package
  org-roam-ui
  :after org-roam
  :custom (org-roam-ui-sync-theme t)
  (org-roam-ui-follow t)
  (org-roam-ui-update-on-save t))

;; from git
;; (defvar org-roam-ui-dir (expand-file-name "org-roam-ui" private-dir))
;; (when (not (file-exists-p org-roam-ui-dir))
;;   (magit-clone-shallow "https://github.com/org-roam/org-roam-ui.git" private-dir '() 1))
;; (add-to-list 'load-path org-roam-ui-dir)
;; (load-library "org-roam-ui")
;; (global-set-key (kbd "C-c n s") 'org-roam-ui-mode)

;; which-key
(which-key-add-key-based-replacements "C-c n" "org-roam")

(provide 'cc-org-roam)

;;; cc-org-roam.el ends here
