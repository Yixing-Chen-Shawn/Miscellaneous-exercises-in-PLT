#lang racket
(require racket/trace)


(define reverse
  (lambda (lst res)
	(if (null? lst)
		res
		(reverse (cdr lst)
				 (cons (car lst) res)))))

(display (reverse-1 lst1)) (newline)


