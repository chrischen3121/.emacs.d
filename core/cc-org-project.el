;;; cc-org-project.el

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
(add-hook 'org-mode-hook
	  (lambda ()
	    (setq org-plantuml-jar-path cc-custom/org-plantuml-jar-path)
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
		     :base-directory ,(concat (file-name-as-directory cc-custom/org-notes-directory) "org")
		     :base-extension "org"
		     :publishing-directory ,(concat (file-name-as-directory cc-custom/org-notes-directory) "docs")
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
		     :base-directory  ,(concat (file-name-as-directory cc-custom/org-notes-directory) "org/resources")
		     :publishing-directory ,(concat (file-name-as-directory cc-custom/org-notes-directory) "docs/resources")
		     :recursive t
		     :base-extension "png\\|jpg\\|gif\\|pdf\\|mp3\\|swf\\|zip\\|gz\\|txt"
		     :publishing-function org-publish-attachment)
		    ("style"
		     :base-directory ,(concat (file-name-as-directory cc-custom/org-notes-directory) "style")
		     :publishing-directory ,(concat (file-name-as-directory cc-custom/org-notes-directory) "docs/style")
		     :base-extension "css\\|js\\|el"
		     :publishing-function org-publish-attachment)
		    ("fonts"
		     :base-directory ,(concat (file-name-as-directory cc-custom/org-notes-directory) "fonts")
		     :publishing-directory ,(concat (file-name-as-directory cc-custom/org-notes-directory) "docs/fonts")
		     :base-extension "eot\\|woff2\\|woff\\|ttf\\|svg"
		     :publishing-function org-publish-attachment)
		    ("all"
		     :components ("orgfiles" "resources" "style" "fonts")
		     :author "Chris Chen"
		     :email "chrischen3121@gmail.com")))))

(provide 'cc-org-project)

;;; cc-org-project.el ends here
