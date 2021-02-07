#lang sicp


(define (square x)
  (* x x))

(define (compose f g)
  (lambda (x)
	(f (g x))))

(display ((compose square inc) 6)) (newline)
