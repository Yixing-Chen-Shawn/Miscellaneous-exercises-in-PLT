#lang racket
(require racket/trace)

(define double
  (lambda (x) (* 2 x)))

(define sum-of-squares
  (lambda (x y) (+ (sqr x)
				   (sqr y))))


(define Pythagrean-triplet
  (lambda (x y z) 
	(if (= (sum-of-squares x y) (sqr z))
		(displayln "Yes")
		(displayln "No"))))

(define func
  (lambda (num)
	(cond
	  [(positive? num) (sqrt num)]
	  [(negative? num) (sqr num)]
	  [else 0])))

