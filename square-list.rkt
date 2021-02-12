#lang racket
(require racket/trace)

(define (square-list lst)
  (if (null? lst)
	  '()
	  (cons (* (car lst) (car lst))
			(square-list (cdr lst)))))


(define (my-map proc lst)
  (if (null? lst)
	  '()
	  (cons (proc (car lst))
			(my-map proc (cdr lst)))))

(define (square-list-1 lst)
  (my-map (lambda (x) (sqr x))
		  lst))

;;(trace square-list-1)
;;(square-list-1 (list 1 2 3 4))
;;(cons 1 '()) = '(1) then (4 1) then '(9 4 1) then '(16 9 4 1)
;; so the answer will be reverse of expected order.
(define (square-list-2 items)
  (define (iter things answer)
	(if (null? things)
		answer
		(iter (cdr things)
			  (cons (sqr (car things))
					answer))))
	(iter (reverse items) '()))

(displayln (square-list-2 (list 1 2 3 4)))

