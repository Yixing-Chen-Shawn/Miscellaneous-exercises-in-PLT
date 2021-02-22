#lang racket
(require racket/trace)

(define (my-filter pred seq)
  (cond
	[(null? seq) '()]
	[(pred (car seq)) (cons (car seq)
							(my-filter pred (cdr seq)))]
	[else (my-filter pred (cdr seq))]))

(trace my-filter)
(displayln (my-filter odd? (list 1 2 3 4 5)))

