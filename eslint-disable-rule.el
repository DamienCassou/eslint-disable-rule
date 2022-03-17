;;; eslint-disable-rule.el --- Commands to add JS comments disabling eslint rules  -*- lexical-binding: t; -*-

;; Copyright (C) 2022 Damien Cassou

;; Authors: Damien Cassou <damien@cassou.me>
;; Version: 0.0.1
;; URL: https://github.com/DamienCassou/eslint-disable-rule
;; Package-Requires: ((emacs "27.2"))
;; Created: 15 March 2022

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Provide commands to quickly add eslint-disable, eslint-disable-line and
;; eslint-disable-next-line comments to your JavaScript files.

;;; Code:

;;; Customization

(defgroup eslint-disable-rule nil
  "Commands to add JS comments disabling eslint rules."
  :group 'external)

(defcustom eslint-disable-rule-find-rules-hook '(eslint-disable-rule-flymake eslint-disable-rule-flycheck)
  "List of functions to find all rules the user might want to ignore."
  :type 'hook
  :options '(eslint-disable-rule-flymake eslint-disable-rule-flycheck))


;;; Utility functions

(defun eslint-disable-rule--find-rule-names ()
  "Return a list of strings of eslint rule names that could be ignored.

This evaluates all functions in `eslint-disable-rule-find-rules-hook',
concatenates the results and remove duplicates."
  (let ((rules (mapcan #'funcall eslint-disable-rule-find-rules-hook)))
    (cl-remove-duplicates rules :test #'string=)))

(defun eslint-disable-rule--find-rule-name (rule-names)
  "Return a string with the name of an eslint rule to ignore among RULE-NAMES.

RULE-NAMES is a list of strings of eslint rule names that could be ignored.
This list can be generated with `eslint-disable-rule--find-rule-names'."
  (cl-case (length rule-names)
    (0 (user-error "No rule to ignore here"))
    (1 (car rule-names))
    (otherwise (completing-read "Which rule? " rule-names))))


;;; Commands

;;;###autoload
(defun eslint-disable-rule-disable-next-line (rule-name)
  "Add eslint-disable-next-line comment above the current line to ignore RULE-NAME."
  (interactive (list (eslint-disable-rule--find-rule-name (eslint-disable-rule--find-rule-names))))
  (save-excursion
    (setf (point) (line-beginning-position))
    (open-line 1)
    (widen)
    (comment-indent)
    (insert "eslint-disable-next-line " rule-name)))


(provide 'eslint-disable-rule)

;;; eslint-disable-rule.el ends here

;; LocalWords:  eslint backend
