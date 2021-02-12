#lang racket

;; interval constructor
(define (make-interval a b) (cons a b))

;; observers for interval
(define (lower-bound x) (car x))
(define (upper-bound x) (cdr x))

;; Arithmetic operations for interval
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
				 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ([p1 (* (lower-bound x) (lower-bound y))]
		[p2 (* (lower-bound x) (upper-bound y))]
		[p3 (* (upper-bound x) (lower-bound y))]
		[p4 (* (upper-bound x) (upper-bound y))])
	(make-interval (min p1 p2 p3 p4)
				   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (if (or (and (< 0 (lower-bound x)) (> 0 (upper-bound x)))
		  (and (> 0 (lower-bound x)) (< 0 (upper-bound x)))
		  (and (< 0 (lower-bound y)) (> 0 (upper-bound y)))
		  (and (> 0 (lower-bound y)) (< 0 (upper-bound y))))
  (error "One or more interval crossing zero.")
  (mul-interval x
	(make-interval (/ 1.0 (upper-bound y))
				   (/ 1.0 (lower-bound y))))))

(define (sub-interval x y)
  (make-interval (- (lower-bound x)
					(upper-bound y))
				 (- (upper-bound x)
					(lower-bound y))))

(define (width-interval w)
  (- (/ (upper-bound w) 2)
	 (/ (lower-bound w) 2)))

(define (print-interval x)
  (display "(")
  (display (lower-bound x))
  (display ",")
  (display (upper-bound x))
  (display ")")
  (newline))

(define r3 (make-interval 1.0 3.0))
(define r4 (make-interval 2.0 4.0))

(display "r3= ") (print-interval (div-interval r3 r4))

(display "r3= ") (display (width-interval r3)) (newline)
(display "r3= ") (display (width-interval r4)) (newline)
(display "mul= ") (display (width-interval (mul-interval r3 r4))) (newline)
(display "div= ") (display (width-interval (div-interval r3 r4))) (newline)



