;;; cc-org.el

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

(defcustom cc-org/org-roam-directory "~/Dropbox/personal/roam"
  "org roam home directory")

(defcustom cc-org/notes-directory "~/notes"
  "home directory for notes")

(defun cc-org/set-company-backends ()
  (set (make-local-variable 'company-backends)
       '(company-capf company-ispell)))

(defun cc-org/start-org-roam-server ()
  "start emacs-server and org-roam-server"
  (interactive)
  (require 'server)
  (unless (server-running-p)
    (server-start)
    (org-roam-server-mode)
    (message "org roam server started."))
  )

(use-package
  org-roam
  :delight
  :hook (after-init . org-roam-mode)
  (org-mode . cc-org/set-company-backends)
  :custom (org-roam-directory cc-org/org-roam-directory)
  :config
  (require 'org-roam-protocol)
  (setq org-roam-completion-system 'ivy)
  :bind (:map org-roam-mode-map
	      (("C-c n r" . org-roam)
	       ("C-c n s" . cc-org/start-org-roam-server)
	       ("C-c n a" . org-roam-alias-add)
	       ("C-c n t" . org-roam-tag-add)
	       ("C-c n /" . completion-at-point)
	       ("C-c n f" . org-roam-find-file)
	       ("C-c n o" . org-open-at-point)
	       ("C-c n c" . org-roam-capture) ; can use templates
	       ("C-c n g" . org-roam-graph))
	      :map org-mode-map
	      (("C-c n i" . org-roam-insert))
	      (("C-c n I" . org-roam-insert-immediate))
	      ))
(which-key-add-key-based-replacements "C-c n" "org-roam")

(use-package org-roam-server
  :after org-roam
  :ensure t
  :config
  (setq org-roam-server-host "127.0.0.1"
	org-roam-server-port 8090
	org-roam-server-authenticate nil
	org-roam-server-export-inline-images t
	;; org-roam-server-serve-files nil
	;; org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
	org-roam-server-network-poll t
	org-roam-server-network-arrows nil
	org-roam-server-network-label-truncate t
	org-roam-server-network-label-truncate-length 60
	org-roam-server-network-label-wrap-length 20))

;; full-text search
(use-package deft
  :after org
  :bind (:map org-mode-map
	      ("C-c n d" . deft))
  :custom
  (deft-recursive t)
  (deft-use-filter-string-for-filename t)
  (deft-default-extension "org")
  (deft-directory cc-org/org-roam-directory))

;; download screenshot ;TODO: specify directories
(use-package org-download
  :after org
  :bind
  (:map org-mode-map
	(("C-c d s" . org-download-screenshot)
	 ("C-c d y" . org-download-yank))))

(setq org-todo-keywords '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "REVIEW(r)" "|" "DONE(d)"
				    "CANCELED(c)")))

(setq org-todo-keyword-faces '(("TODO" . org-warning)
			       ("INPROGRESS" . "yellow")
			       ("WAITING" . "purple")
			       ("REVIEW" . "orange")
			       ("DONE" . "green")
			       ("CANCELED" .  "red")))

(use-package
  graphviz-dot-mode
  :defer t
  )

(use-package
  plantuml-mode
  :custom (plantuml-executable-path "plantuml")
  (plantuml-default-exec-mode 'executable)
  )

(use-package
  htmlize
  :defer t
  )

(use-package
  org-bullets
  :hook (org-mode . org-bullets-mode)
  )

(use-package
  org-alert
  :defer t
  :custom (alert-default-style 'libnotify)
  )

(require 'ox-md)

(use-package
  org
  :hook (org-mode . flyspell-mode)
  (org-mode . smartparens-mode)
  )

(add-hook 'org-mode-hook
	  (lambda ()
	    (setq org-plantuml-jar-path "/usr/share/plantuml/plantuml.jar")
	    (setq org-html-mathjax-options
		  '((path
		     "https://cdn.bootcdn.net/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS_HTML")
		    (scale "100")
		    (align "left")
		    (font "TeX")
		    (linebreaks "false")
		    (autonumber "AMS")
		    (indent "2em")
		    (multlinewidth "85%")
		    (tagindent ".8em")
		    (tagside "left")))
	    (setq org-publish-project-alist
		  `(("orgfiles"
		     :base-directory ,(concat (file-name-as-directory cc-org/notes-directory) "org")
		     :base-extension "org"
		     :publishing-directory ,(concat (file-name-as-directory cc-org/notes-directory) "docs")
		     :recursive t
		     :publishing-function org-html-publish-to-html
		     :headline-levels 3
		     :section-numbers nil
		     :with-toc t
		     :html-head-include-scripts nil
		     :with-title t
		     :html-html5-fancy t
		     :auto-index nil
		     :auto-sitemap t
		     :style nil
		     :html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"https://gongzhitaao.org/orgcss/org.css\">"
		     :html-preamble nil
		     :html-postamble nil
		     :sitemap-title "chrischen's notes"
		     :sitemap-filename "sitemap.org"
		     :exclude "sitemap.org")
		    ("resources"
		     :base-directory  ,(concat (file-name-as-directory cc-org/notes-directory) "org/resources")
		     :publishing-directory ,(concat (file-name-as-directory cc-org/notes-directory) "docs/resources")
		     :recursive t
		     :base-extension "png\\|jpg\\|gif\\|pdf\\|mp3\\|swf\\|zip\\|gz\\|txt"
		     :publishing-function org-publish-attachment)
		    ("style"
		     :base-directory ,(concat (file-name-as-directory cc-org/notes-directory) "style")
		     :publishing-directory ,(concat (file-name-as-directory cc-org/notes-directory) "docs/style")
		     :base-extension "css\\|js\\|el"
		     :publishing-function org-publish-attachment)
		    ("fonts"
		     :base-directory ,(concat (file-name-as-directory cc-org/notes-directory) "fonts")
		     :publishing-directory ,(concat (file-name-as-directory cc-org/notes-directory) "docs/fonts")
		     :base-extension "eot\\|woff2\\|woff\\|ttf\\|svg"
		     :publishing-function org-publish-attachment)
		    ("all"
		     :components ("orgfiles" "resources" "style" "fonts")
		     :author "Chris Chen"
		     :email "chrischen3121@gmail.com")))))

;; TODO: set fonts style
;; (setq org-html-head (@-load-file-contents (expand-file-name "~/.emacs.d/template.html")))
;; (setq org-html-preamble t)
;; (setq org-html-postamble (@-load-file-contents (expand-file-name "~/.emacs.d/footer.html")))

(provide 'cc-org)

;;; cc-org.el ends here
