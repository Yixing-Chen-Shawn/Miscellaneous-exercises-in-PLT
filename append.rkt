#lang racket
(require racket/trace)


(define append
  (lambda (lst1 lst2)
	(if (null? lst1)
		lst2
		(cons (car lst1) (append (cdr lst1) lst2)))))

(define lst1 '(1 3 5 7 9))
(define lst2 '(2 4 6 8 10))
(trace append)
(display (append lst1 lst2))

