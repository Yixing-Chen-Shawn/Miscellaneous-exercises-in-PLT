#lang racket

;;clever but more obscure way of implementing pair using procedural representation
(define (my-cons x y)
  (lambda (m) (m x y)))

(define (my-car z)
  (z (lambda (p q) p)))

(define (my-cdr z)
  (z (lambda (p q) q)))

(display (my-car (my-cons 3 4)))
(newline)
(display (my-cdr (my-cons 3 4)))
(newline)

