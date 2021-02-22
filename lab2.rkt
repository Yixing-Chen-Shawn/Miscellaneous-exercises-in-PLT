#lang racket
(require racket/trace)


(define (factorial n)
  (if (= n 0)
	  1
	  (* n
		 (factorial (- n 1)))))

(define (sum-odd lst)
  (if (null? lst)
	  0
	  (+ (if (odd? (first lst))
			 (first lst)
			 0)
		 (sum-odd (rest lst)))))

(define (even-list lst)
  (if (null? lst)
	  '()
	  (if (even? (car lst))
		  (cons (car lst)
				(even-list (cdr lst)))
		  (even-list (cdr lst)))))

(define (sum-list lst)
  (cond [(null? lst) 0]
        [(symbol? lst) 0]
        [(integer? lst) lst]
        [else (+ (sum-list (car lst))
                 (sum-list (cdr lst)))]))

(define (take n lst)
  (if (= n 0)
      '()
      (cons (car lst)
            (take (- n 1) (cdr lst)))))

(define (drop n lst)
  (cond [(>= n (length lst)) '()]
        [(= n 1) (cdr lst)]
        [else (drop (- n 1) (cdr lst))]))

(define lst '((1 2) a (3 b) (4 (5 c)) 6))
(define lst-1 '(1 3 5 2 7 4))
