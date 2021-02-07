#lang sicp

(define (double f)
  (lambda (x)
	(f (f x))))

(display ((double inc) 3)) (newline)
