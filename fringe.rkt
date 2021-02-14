#lang racket
(require racket/trace)

(define x (list (list 1 2) (list 3 4)))

;; less readable version of fringe
#;(define (fringe tree)
  (cond
	[(null? tree) '()] ;; empty tree
	[(not (pair? tree)) (list tree)] ;;leaves of tree
	[else
	  (append (fringe (car tree))  ;; all elements in left subtree
			  (fringe (cadr tree)))])) ;; all elements in right subtree


;; more readable version of this
(define (fringe tree)
  (cond
	[(empty-tree? tree) '()]
	[(leaf? tree) (list tree)]
	[else
	  (append (fringe (left-branch tree))
			  (fringe (right-branch tree)))]))

(define (empty-tree? tree)
  (null? tree))

(define (leaf? tree)
  (not (pair? tree)))

(define (left-branch tree)
  (car tree))

(define (right-branch tree)
  (cadr tree))

(trace fringe)
(fringe x)
