#lang racket
(require racket/trace)

(define (make-rat n d) (cons n d)
  (let ([g (gcd n d)]
		[denom-sign (if (> d 0) 1 (- 1))])
	(cons (* (/ n g) denom-sign)
		  (* (/ d g) denom-sign))))
(define (numer x) (car x))
(define (denom x) (cdr x))

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
			   (* (numer y) (denom x)))
			(* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
			   (* (numer y) (denom x)))
			(* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
			(* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
			(* (denom x) (numer y))))

(define (equal-rat? x y)
  (= (* (numer x) (denom y))
	 (* (numer y) (denom x))))

(define (print-rat x)
  (display (numer x))
  (display "/")
  (display (denom x)))

(define one-half (make-rat 1 2))
(print-rat one-half)
(newline)
(define one-third (make-rat 1 3))
(print-rat (add-rat one-third one-third))
(newline)
(print-rat (mul-rat one-third one-half))
(newline)

