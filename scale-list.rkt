#lang racket
(require racket/trace)

(define (scale-list items factor)
  (if (null? items)
	  '()
	  (cons (* (car items) factor)
			(scale-list (cdr items) factor))))

(scale-list (list 1 2 3 4 5 6) 10)


;; map implementation
(define (my-map proc items)
  (if (null? items)
	  '()
	  (cons (proc (car items))
			(my-map proc (cdr items)))))

;; mapping over list
(define (scale-list-1 items factor)
  (my-map (lambda (x) (* x factor))
	   items))
(trace scale-list-1)
(scale-list-1 (list 1 2 3 4 5 6) 10)
