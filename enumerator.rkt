#lang racket
(require racket/trace)

(define (enumerate-interval low high)
  (if (> low high)
	  '()
	  (cons low (enumerate-interval (+ low 1) high))))

(trace enumerate-interval)
;; enumerate from 2 to 7 (inclusive)
;; (enumerate-interval 2 7)

;; enumerate the leaves of a tree
(define (enumerate-tree tree)
  (cond
	[(null? tree) '()]
	[(not (pair? tree)) (list tree)]
	[else (append (enumerate-tree (car tree)) ;; use append to only keep one single bracket at the end.
				  (enumerate-tree (cdr tree)))]))

(trace enumerate-tree)
(enumerate-tree (list 1 (list 2 (list 3 4)) 5))

