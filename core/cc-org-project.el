;;; cc-org-project.el

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

(defcustom cc-org-project/org-notes-directory "~/notes"
  "home directory for notes"
  :type 'string
  :group 'cc-org-project)

(defcustom cc-org-project/org-plantuml-jar-path "/usr/share/plantuml/plantuml.jar"
  "path of plantuml.jar"
  :type 'string
  :group 'cc-org-project)

(add-hook 'org-mode-hook (lambda ()
                           (setq org-plantuml-jar-path cc-org-project/org-plantuml-jar-path)
                           (setq org-html-mathjax-options '((path
                                                             "https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS_HTML")
                                                            (scale "100")
                                                            (align "left")
                                                            (font "TeX")
                                                            (linebreaks "false")
                                                            (autonumber "AMS")
                                                            (indent "2em")
                                                            (multlinewidth "85%")
                                                            (tagindent ".8em")
                                                            (tagside "left")))
                           (setq org-publish-project-alist `(("orgfiles" :base-directory ,(concat
                                                                                           (file-name-as-directory
                                                                                            cc-org-project/org-notes-directory)
                                                                                           "org")
                                                              :base-extension "org"
                                                              :publishing-directory ,(concat
                                                                                      (file-name-as-directory
                                                                                       cc-org-project/org-notes-directory)
                                                                                      "docs")
                                                              :recursive t
                                                              :publishing-function
                                                              org-html-publish-to-html
                                                              :headline-levels 3
                                                              :section-numbers nil
                                                              :with-toc t
                                                              :html-head-include-scripts nil
                                                              :with-title t
                                                              :html-html5-fancy t
                                                              :auto-index nil
                                                              :auto-sitemap t
                                                              :style nil
                                                              :html-head
                                                              "<link rel=\"stylesheet\" type=\"text/css\" href=\"https://gongzhitaao.org/orgcss/org.css\">"
                                                              :html-preamble nil
                                                              :html-postamble nil
                                                              :sitemap-title "Chris Chen's notes"
                                                              :sitemap-filename "sitemap.org"
                                                              :exclude "sitemap.org")
                                                             ("all" :components ("orgfiles")
                                                              :author "Chris Chen"
                                                              :email "chrischen3121@gmail.com")))))

(provide 'cc-org-project)

;;; cc-org-project.el ends here
