;;; cc-org-roam.el

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

;;; Code:
(use-package
  org-roam
  :init (setq org-roam-v2-ack t)
  :delight
  :custom (org-roam-directory cc-custom/org-roam-directory)
  :config (org-roam-setup)
  (require 'org-roam-protocol)
  ;; (setq org-roam-completion-system 'ivy)
  :bind (("C-c n c" . org-roam-capture)
	 ("C-c n f" . org-roam-node-find)
	 ("C-c n g" . org-roam-graph)
	 ("C-c n i" . org-roam-node-insert)
	 ("C-c n b" . org-roam-buffer-toggle)
	 :map org-mode-map ("C-c n a" . org-roam-alias-add)
	 ("C-c n t" . org-roam-tag-add))
  ;; :bind (:map org-roam-mode-map
  ;;	      (("C-c n r" . org-roam)
  ;;	       ("C-c n s" . cc-org/start-org-roam-server)
  ;;	       ("C-c n a" . org-roam-alias-add)
  ;;	       ("C-c n t" . org-roam-tag-add)
  ;;	       ("C-c n /" . completion-at-point)
  ;;	       ("C-c n f" . org-roam-find-file)
  ;;	       ("C-c n o" . org-open-at-point)
  ;;	       ("C-c n c" . org-roam-capture) ; can use templates
  ;;	       ("C-c n g" . org-roam-graph))
  ;;	      :map org-mode-map
  ;;	      (("C-c n i" . org-roam-insert))
  ;;	      (("C-c n I" . org-roam-insert-immediate))
  ;;	      )
  )
(which-key-add-key-based-replacements "C-c n" "org-roam")

(provide 'cc-org-roam)

;;; cc-org-roam.el ends here
