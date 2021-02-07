#lang racket

;;calculate primeter and area of rectangle
(define (primeter-rect r)
  (* 2 (+ (width-rect r) (height-rect r))))

(define (area-rect r)
  (* (width-rect r) (height-rect r)))

;;points constructure and observer
(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

;; calculate the distance between two points
(define (distance-point p1 p2)
  (sqrt
	(+ (sqr (- (x-point p1) (x-point p2)))
	   (sqr (- (y-point p1) (y-point p2))))))

;;rectangle constructors and observers
(define (make-rect origin height width ang)
  (cons (cons height width) (cons origin ang)))

(define (origin-rect r) (car (cdr r)))
(define (angle-rect r) (cdr (cdr r)))

;;public interface
(define (height-rect r) (car (car r)))
(define (width-rect r) (cdr (car r)))

;;test
(define origin1 (make-point 1 1))
(define height1 4.0)
(define width1 5.0)
(define angle1 0.2)

(define r1 (make-rect origin1 height1 width1 angle1))
(display "Rectangle 1: ") (newline)
(display "Primeter: ") (display (primeter-rect r1)) (newline)
(display "Area: ") (display (area-rect r1)) (newline)

