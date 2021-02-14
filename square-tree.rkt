#lang racket
(require racket/trace)

(define (square-tree tree)
  (cond
	[(null? tree) null]
	[(not (pair? tree)) (sqr tree)] ;; leaves of the tree
	[else
	  (cons (square-tree (car tree))
			(square-tree (cdr tree)))]))

;; use map to iterate
(define (square-tree-iter tree)
  (map (lambda (sub-tree)
		 (if (pair? sub-tree)
			 (square-tree-iter sub-tree)
			 (sqr sub-tree)))
	   tree))

;; '((1 2) (3 4))
(define lst (list (list 1 2) (list 3 4)))
(trace square-tree-iter)
(square-tree-iter lst)

