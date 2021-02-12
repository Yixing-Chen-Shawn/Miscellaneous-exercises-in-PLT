#lang racket
(require racket/trace)

(define f
  (lambda (x y . z)
	z))

(define g
  (lambda w
	w))

(displayln (f 1 2 3 4 5 6))
(displayln (g 1 2 3 4 5 6))

;; same-parity problem
(define (same-parity sample . others)
  (filter (if (even? sample)
			  even?
			  odd?)
		  (cons sample others)))
(trace same-parity)
(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)

