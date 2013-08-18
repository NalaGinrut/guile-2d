;;; guile-2d
;;; Copyright (C) 2013 David Thompson <dthompson2@worcester.edu>
;;;
;;; Guile-2d is free software: you can redistribute it and/or modify it
;;; under the terms of the GNU Lesser General Public License as
;;; published by the Free Software Foundation, either version 3 of the
;;; License, or (at your option) any later version.
;;;
;;; Guile-2d is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;; Lesser General Public License for more details.
;;;
;;; You should have received a copy of the GNU Lesser General Public
;;; License along with this program.  If not, see
;;; <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Font rendering.
;;
;;; Code:

(define-module (2d font)
  #:use-module (figl gl)
  #:use-module (srfi srfi-9)
  #:use-module (system foreign)
  #:use-module (2d wrappers ftgl)
  #:export (<font>
            make-font
            font?
            font-ftgl-font
            font-size
            load-font
            render-font))

;; Font objects represent an FTGL texture font at a given size.
(define-record-type <font>
  (make-font ftgl-font size)
  font?
  (ftgl-font font-ftgl-font)
  (size font-size))

(define (load-font filename size)
  (let ((ftgl-font (ftgl-create-texture-font filename)))
    ;; Hardcoded 72 dpi for now.
    (ftgl-set-font-face-size ftgl-font size 72)
    (make-font ftgl-font size)))

(define (render-font font text color alignment)
  (gl-color 1 1 1)
  (ftgl-render-font (font-ftgl-font font)
                    text
                    (ftgl-render-mode all)))
