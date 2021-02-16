#lang racket
(require racket/trace)

;; reformulate sum-odd-squares as in the signal-flow diagram, indeed inspired by its modularity. 
(define (my-filter pred seq)
  (cond
	[(null? seq) '()]
	[(pred (car seq)) (cons (car seq)
							(my-filter pred (cdr seq)))]
	[else (my-filter pred (cdr seq))]))

(define (accumulate op init seq)
  (if (null? seq)
	  init
	  (op (car seq)
		  (accumulate op init (cdr seq)))))


(define (enumerate-interval low high)
  (if (> low high)
	  '()
	  (cons low (enumerate-interval (+ low 1) high))))

;; enumerate all the leaves of a tree
(define (enumerate-tree tree)
  (cond
	[(null? tree) '()]
	[(not (pair? tree)) (list tree)]
	[else (append (enumerate-tree (car tree)) ;; use append to only keep one single bracket at the end.
				  (enumerate-tree (cdr tree)))]))


(define (sum-odd-squares tree)
  (accumulate
	+ 0 (map sqr (my-filter odd? (enumerate-tree tree)))))

;;(define tree (list (list 1 2) 3 4))
;;(trace sum-odd-squares)
;;(sum-odd-squares tree)
(define (fib n)
  (if (<= n 2)
	  1
	  (+ (fib (- n 1)) (fib (- n 2)))))

(define (even-fibs n)
  (accumulate
	cons
	'()
	;;a graceful and effective piece of code
	;; first enumerate all numbers from 0 and n, and then apply fib to it
	;; and filter out all the odd ones and keep only even ones. 
	(my-filter even? (map fib (enumerate-interval 0 n)))))

(trace even-fibs)
;;(even-fibs 10)
;;(display (map fib (enumerate-interval 0 10)))

;; The value of expressing programs as sequence operations is that this helps us make program designs that are modular, that is, designs that are constructed by combining relatively independent pieces. We can en- courage modular design by providing a library of standard components together with a conventional interface for connecting the components in flexible ways.

;; more about modular construction(useful tool for controlling complexity in engineering design)

(define (list-fib-squares n)
  (accumulate
	cons
	'()
	(map sqr (map fib (enumerate-interval 0 n)))))

(trace list-fib-squares)
;;(list-fib-squares 10)

(define (product-of-square-of-odd-elements seq)
  (accumulate
	*
	1
	(map sqr (my-filter odd? seq))))
(trace product-of-square-of-odd-elements)
(product-of-square-of-odd-elements (list 1 2 3 4 5))

