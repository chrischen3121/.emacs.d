;;; cc-functions.el --- Summary

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

;;; Code:

(defmacro cc-functions/measure-time
    (&rest
     body)
  "Measure the time it takes to evaluate BODY."
  `(let ((time (current-time))) ,@body (message "%s" (float-time (time-since time)))))


(defun cc-functions/time-since-startup
    (&optional
     prefix)
  "Display the time that past since emacs startup. Add PREFIX if given at the
start of message for debug purposes."
  (interactive)
  (let* ((prefix (or prefix
                     ""))
         (time (float-time (time-since before-init-time)))
         (str (format "%s%s seconds" prefix time)))
    (if (or (not (string-empty-p prefix))
            (called-interactively-p 'interactive))
        (message str) str)))
(provide 'cc-functions)

;;; cc-functions.el ends here
