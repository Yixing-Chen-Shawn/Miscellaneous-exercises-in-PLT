#lang racket
(require racket/trace)

(define x (list (list 1 2) (list 3 4)))

(define reverse-helper
  (lambda (lst res)
	(if (null? lst)
		res
		(reverse-helper (cdr lst)
				 (cons (car lst) res)))))

(define reverse
  (lambda (x)
	(reverse-helper x '())))

;;(trace reverse-helper)
;;(reverse x)

#;(define (deep-reverse tree)
  (cond 
	[(null? tree) '()]
	[(not (pair? tree)) tree]
	[else
	  (reverse (list (deep-reverse (car tree))
					 (deep-reverse (cadr tree))))]))

;; more readable version of deep-reverse
(define (deep-reverse tree)
  (cond
	[(empty-tree? tree) '()]
	[(leaf? tree) tree]
	[else
	  (reverse (make-tree (deep-reverse (left-branch tree))
						  (deep-reverse (right-branch tree))))]))

(define (empty-tree? tree)
  (null? tree))

(define (leaf? tree)
  (not (pair? tree)))

(define (make-tree left-branch right-branch)
  (list left-branch right-branch))

(define (left-branch tree)
  (car tree))

(define (right-branch tree)
  (cadr tree))

(trace reverse-helper)
(trace deep-reverse)
(deep-reverse x)
