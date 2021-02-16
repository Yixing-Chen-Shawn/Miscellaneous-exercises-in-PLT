#lang racket
(require racket/trace)

;; enumerates the integers from 0 to n
;; computes the Fibonacci number for each integer;
;; filters them, selecting the even ones; and
;; accumulates the results using cons, starting with the empty list.(最大的放最后，符合ordering)

(define (fib n)
  (if (<= n 2)
	  1
	  (+ (fib (- n 1)) (fib (- n 2)))))

(define (even-fibs n)
  (define (next k)
	(if (> k n)
		'()
		(let ([f (fib k)])
		  (if (even? f)
			  (cons f (next (+ k 1))) ;;always execute til k > n, and return '(), reversely going back while consing element
			  (next (+ k 1))))))
  (next 0))

(trace even-fibs)
(even-fibs 10)
