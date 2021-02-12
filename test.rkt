#lang racket
(require racket/trace)

(define (my-cons x y) 
  (define (dispatch m)
	(cond ((= m 0) x) ((= m 1) y)
		  (else (error "Argument not 0 or 1: CONS" m)))) dispatch)
(define (my-car z) (z 0)) 
(define (my-cdr z) (z 1))

(display ((my-cons 1 2) 0)) (newline)
(display (my-car (my-cons 4 5))) (newline)
(display (my-cdr (my-cons 6 (my-cons 13 14)))) (newline)

(define only-positive
  (lambda (lst)
	(if (null? lst)
		'()
		(if (<= (car lst) 0)
			(only-positive (cdr lst))
			(cons (car lst) (only-positive (cdr lst)))))))

(display (only-positive '(-1 -3 -4 2 4 -1 3 -6 3 5))) (newline)

(define length-iter
  (lambda (lst n)
	(if (null? lst)
		n
		(length-iter (cdr lst) (+ 1 n)))))

(define (length lst)
  (length-iter lst 0))

(define lst '(1 2 3 4 5 6))
(display (length lst))
(newline)

(define append
  (lambda (lst1 lst2)
	(if (null? lst1)
		lst2
		(cons (car lst1) (append (cdr lst1) lst2)))))

(define lst1 '(1 3 5 7 9))
(define lst2 '(2 4 6 8 10))
(trace append)
(display (append lst1 lst2))
(newline)
(define (reverse-1 lst)
  (reverse lst '())) 

(define reverse
  (lambda (lst res)
	(if (null? lst)
		res
		(reverse (cdr lst)
				 (cons (car lst) res)))))

(display (reverse-1 lst1)) (newline)

(define (list-ref items n)
  (if (= n 0)
	  (car items)
	  (list-ref (cdr items) (- n 1))))
(display (list-ref lst 3))(newline)

(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(define (first-denomination coin-values)
  (car coin-values))
(define (except-first-denomination coin-values)
  (cdr coin-values))
(define (no-more? coin-values)
  (null? coin-values))

(define (cc amount coin-values)
    (cond ((= amount 0)
            1)
          ((or (< amount 0) (no-more? coin-values))
            0)
          (else
            (+ (cc amount
                   (except-first-denomination coin-values))
               (cc (- amount
                      (first-denomination coin-values))
                   coin-values)))))

(displayln (cc 100 us-coins))
