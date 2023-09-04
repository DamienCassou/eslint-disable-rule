;;; eslint-disable-rule-test.el --- Tests for eslint-disable-rule         -*- lexical-binding: t; -*-

;; Copyright (C) 2022-2023  Damien Cassou

;; Author: Damien Cassou <damien@cassou.me>
;; Version: 0.3.0
;; URL: https://github.com/DamienCassou/beginend
;; Package-requires: ((emacs "27.2"))

;; This program is free software; you can redistribute it and/or modify
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

;; Tests for eslint-disable-rule.

;;; Code:

(require 'ert)
(require 'eslint-disable-rule)

(ert-deftest eslint-disable-rule-test-find-rule-names-keep-order ()
  (let* ((eslint-disable-rule-find-rules-hook (list (lambda () '(a b a c))))
         (result (eslint-disable-rule--find-rule-names)))
    (should (equal result '(a b c)))))

(provide 'eslint-disable-rule-test)
;;; eslint-disable-rule-test.el ends here
