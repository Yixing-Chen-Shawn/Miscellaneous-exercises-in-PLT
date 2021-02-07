#lang sicp

(define tolerance 0.00001)

(define (average a b)
  (/ (+ a b) 2))

;;calculate the fixed point of a function with error tolerance 0.00001
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
	(< (abs (- v1 v2))
	   tolerance))
  (define (try guess)
	(let ([next (f guess)])
	  (if (close-enough? guess next)
		  next
		  (try next))))
  (try first-guess))

(define dx 0.00001)

;;differentiation of a function, f(x) = x^3, then D(f(x)) = 3*x^2
(define (deriv g)
  (lambda (x)
	(/ (- (g (+ x dx)) (g x))
	   dx)))

;; f(x) = x - g(x) / D(g(x)) 
;; for x when g(x) = 0 is a fixed point of x -> f(x)
(define (newton-transform g)
  (lambda (x)
	(- x (/ (g x)
			((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g)
			   guess))

(define (cubic a b c)
  (lambda (x)
	(+ (* x x x) (* a x x ) (* b x) c)))

(define a 1)
(define b 1)
(define c 1)

(display (newtons-method (cubic a b c) 1))
(newline)
(display (newtons-method (cubic 2 1 1) 1))


