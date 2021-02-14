#lang racket
(require racket/trace)

;; abstract previous answer (square-tree tree) 
(define (tree-map f tree)
  (cond
	[(null? tree) null] ;; empty tree
	[(not (pair? tree)) (f tree)]  ;; leaves node
	[else                          ;; recursivly handle left and right subtree
	  (cons (tree-map f (car tree))
			(tree-map f (cdr tree)))]))

(define lst (list (list 1 2) (list 3 4)))

(define (tree-map-1 f tree)
  (map (lambda (sub-tree)
		 (if (pair? sub-tree)
			 (tree-map-1 f sub-tree)
			 (f sub-tree)))
	   tree))

(trace tree-map-1)
(tree-map-1 sqr lst)

