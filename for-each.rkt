#lang racket
(require racket/trace)

#;(define (for-each proc items)
  (if (null? items)
	  '()
	  (cons (proc (car items))
			(for-each proc (cdr items)))))
(define (for-each p lst)
    (cond ((not (null? lst))
            (p (car lst))
            (for-each p (cdr lst)))))
(trace for-each)
(for-each
  (lambda (x)
	(displayln x))
  '(57 321 88))
