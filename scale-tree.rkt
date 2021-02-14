#lang racket
(require racket/trace)

;; recursive way of factorizing leaves of tree
(define (scale-tree tree factor)
  (cond
	[(null? tree) null]
	[(not (pair? tree)) (* tree factor)]
	[else 
	  (cons (scale-tree (car tree) factor)
			(scale-tree (cdr tree) factor))]))

;; use map to iterate it
(define (scale-tree-iter tree factor)
  (map (lambda (sub-tree)
		 (if (pair? sub-tree)
			 (scale-tree-iter sub-tree factor)
			 (* sub-tree factor)))
	   tree))

;; '(1 (2 (3 4) 5) (6 7))
(define lst (list 1 (list 2 (list 3 4) 5) (list 6 7)))
(trace scale-tree-iter)
(scale-tree-iter lst 10)

