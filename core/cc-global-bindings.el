;;; cc-global-bindinds.el

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

(global-set-key (kbd "S-SPC") #'set-mark-command)

(global-set-key (kbd "C-x p i") #'package-install)
(global-set-key (kbd "C-x p l") #'list-packages)
(global-set-key (kbd "C-x p r") #'package-refresh-contents)
(which-key-add-key-based-replacements "C-x p" "packages")


(provide 'cc-global-bindings)
;;; cc-global-bindinds.el ends here
