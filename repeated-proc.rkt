#lang racket
(require racket/trace)

(define (square x)
  (* x x))

(define (compose f g)
  (lambda (x)
	(f (g x))))

;;with compose function
(define (repeated f n)
  (if (= n 1)
	  f
	  (compose f 
			   (repeated f (- n 1)))))

;;without compose fucntion
(define (repeated-1 f n)
  (if (= n 1)
	  f
	  (lambda (x)
		(let ([fs (repeated-1 f (- n 1))])
			  (f (fs x))))))


(trace repeated)
(trace compose)
(trace square)
(trace repeated-1)
((repeated-1 square 4) 5)
(display ((repeated square 2) 5)) (newline)
