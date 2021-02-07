#lang eopl

(define (my-cons x y) 
  (define (dispatch m)
	(cond ((= m 0) x) ((= m 1) y)
		  (else (eopl:error "Argument not 0 or 1: CONS" m)))) dispatch)
(define (my-car z) (z 0)) 
(define (my-cdr z) (z 1))

(display ((my-cons 1 2) 0)) (newline)
(display (my-car (my-cons 4 5))) (newline)
(display (my-cdr (my-cons 6 (my-cons 13 14)))) (newline)

