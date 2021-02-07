#lang eopl
(require racket/trace)

;;Ex1.15
;;duple : Int * SchemeVal -> Listof(SchemeVal)
;;usage : (duple n x) returns a list containing n copies of x
(define duple
  (lambda (n x)
    (cond
      [(= n 0) (list)]
      [else (cons x (duple (- n 1) x))])))

;;Ex1.16
;;invert : Listof(2-list) -> Listof(2-list)
;;usage : (invert lst), where lst is a list of 2-lists (lists of length two),
;;        returns a list with each 2-list reversed.
;;recursively invert
(define invert
  (lambda (lst)
    (cond
      [(null? lst) (list)]
      [else (cons
             (list (cadar lst) (caar lst))
             (invert (cdr lst)))])))

;;Another way for inverting 2-list interatively is to use map 
(define invert-2
  (lambda (lst)
    (map (lambda (x) (list (cadr x) (car x)))
           lst)))

;;Ex1.17
;;down : Listof(ShemeVal) -> Listof(SchemeVal)
;;usage : (down lst) wraps parentheses around each top-level element for lst.
;;reversively add parentheses to top-level elements in the list
(define down
  (lambda (lst)
    (if (null? lst)
        '()
        (cons (cons (car lst) '())
              (down (cdr lst))))))

;;use map to do it iteratively
(define down-2
  (lambda (lst)
    (map (lambda (x) (list x))
         lst)))

;;Ex1.18
;;swapper : Sym * Sym * S-list -> S-list
;; usage: (swapper s1 s2 slist) returns a list the same as slist, but with all
;;        occurrences of s1 replaced by s2 and all occurrences of s2 replaced
;;        by s1.
(define swapper
  (lambda (s1 s2 slist)
    (if (null? slist)
        '()
        (cons
         (swapper-in-s-exp s1 s2 (car slist))
         (swapper s1 s2 (cdr slist))))))

;;swapper-in-s-exp : Sym * Sym * S-exp -> S-exp
;;usage : auxiliary procedure for check if S-exp is a symbol or a list, and produce a
;;correct output.
(define swapper-in-s-exp
  (lambda (s1 s2 sexp)
    (if (symbol? sexp)
        (cond
          [(eqv? sexp s1) s2]
          [(eqv? sexp s2) s1]
          [else sexp])
        ;;if sexp is a list
        (swapper s1 s2 sexp))))

;;iterative way
(define swapper-2
  (lambda (s1 s2 slist)
    (map (lambda (sexp)
           (if (symbol? sexp)
               (if (eqv? sexp s1)
                   s2
                   (if (eqv? sexp s2)
                       s1
                       sexp))
               (swapper-2 s1 s2 sexp)))
         slist)))
;;Ex1.19
;;list-set : Listof(SchemeVal) * Int * SchemeVal -> Listof(SchemeVal)
;; usage: (list-set lst n x) returns a list like lst, except that the n-th
;;        element, using zero-based indexing, is x.
(define list-set
  (lambda (lst n x)
    (if (null? lst)
        (report-list-too-short n)
        (if (zero? n)
            (cons x (cdr lst))
            (cons (car lst) (list-set (cdr lst) (- n 1) x))))))



(define report-list-too-short
  (lambda (n)
    (eopl:error 'list-set
                "List too short by ~s elements.~%" (+ n 1))))

;(display (list-set '(a b c d) 2 '(1 2)))
;(newline)
;(display (list-ref (list-set '(a b c d) 3 '(1 5 10)) 3))

;;Ex1.20
;;count-occurences : Sym * S-list -> Int
;; usage: (count-occurrences s slist) returns the number of occurrences of s
;; in slist.
;; use recursion
(define count-occurrences
  (lambda (s slist)
    (if (null? slist)
        0
        (if (symbol? (car slist))
            (if (eqv? (car slist) s)
                (+ (count-occurrences s (cdr slist)) 1)
                (count-occurrences s (cdr slist)))
            (+ (count-occurrences s (car slist))
               (count-occurrences s (cdr slist)))))))
                
;(display (count-occurrences 'x '((f x) y (((x z) x)))))

;;Ex1.21
;; product-symbol-list : Sym * Listof(Sym) -> Listof(2-list)
;; usage: (product-symbol-list s '(s0 s1 s2 ...))
;;        = ((s s0) (s s1) (s s2) ...)
(define product-symbol-list
  (lambda (s sos)
    (if (null? sos)
        '()
        (cons (list s (car sos))
              (product-symbol-list s (cdr sos))))))

;;product : S-list * S-list -> Listof(2-list)
;;usage: (product sos1 sos2), where sos1 and sos2 are each a list of symbols
;;        without repetitions, returns a list of 2-lists that represents the
;;        Cartesian product of sos1 and sos2. The 2-lists may appear in any
;;        order.
;;use recursion
(define product
  (lambda (sos1 sos2)
    (if (null? sos1)
        '()
        (append (product-symbol-list (car sos1) sos2)
                (product (cdr sos1) sos2)))))

;(product '(a b c) '(x y))

;;Ex1.22
;;filter-in : pred * List -> List
;;usage: (filter-in pred lst) returns the list of those elements in lst
;;        that satisfy the predicate pred.
(define filter-in
  (lambda (pred lst)
    (if (null? lst)
        '()
        (if (pred (car lst))
            (cons (car lst) (filter-in pred (cdr lst)))
            (filter-in pred (cdr lst))))))
;(filter-in symbol? '(a (b c) 17 foo))

;;Ex1.23
;; list-index-count : pred * List * Int -> Int/Bool
;;usage: (list-index-count pred lst count) returns count add the 0-based
;;        position of the first element of lst that satisfies the predicate
;;        pred. If no element of lst satisfies the predicate, then list-index
;;        returns #f.
(define list-index-count
  (lambda (pred lst count)
    (if (null? lst)
        #f
        (if (pred (car lst))
            count
            (list-index-count pred (cdr lst) (+ 1 count))))))

;;list-index : pred * List -> Int/Bool
(define list-index
  (lambda (pred lst)
    (list-index-count pred lst 0)))

;(display (list-index number? '(a 2 (1 3) b 7)))
;(newline)
;(display (list-index symbol? '(a (b c) 17 foo)))

;;Ex1.24
;; every : pred * List -> Bool
;; usage : (every? pred lst) returns #f if any element of lst fails to satisfy pred,
;; and returns #t otherwise.
;;use and operator
(define every?
  (lambda (pred lst)
    (if (null? lst)
        #t
        (and (pred (car lst))
             (every? pred (cdr lst))))))

(define every-2?
  (lambda (pred lst)
    (if (null? lst)
        #t
        (if (pred (car lst))
            (every-2? pred (cdr lst))
            #f))))


;(display  (every-2? number? '(a b c 3 e)))
;(newline)
;(display (every-2? number? '(1 2 3 5 4)))

;;Ex1.25
;; exist : pred * List -> Bool
;; usage : (exists? pred lst) returns #t if any element of lst satisfies pred,
;; and returns #f otherwise.
(define exists?
  (lambda (pred lst)
    (if (null? lst)
        #f
        (if (pred (car lst))
            #t
            (exists? pred (cdr lst))))))

(define exists-2?
  (lambda (pred lst)
    (if (null? lst)
        #f
        (or (pred (car lst))
            (exists-2? pred (cdr lst))))))

;(display (exists-2? number? '(a b c 3 e)))
;(display (exists-2? number? '(a b c d e)))

;;Ex1.26
;; up : List -> List
;; usage: (up lst) removes a pair of parentheses from each top-level element
;;        of lst. If a top-level element is not a list, it is included in the
;;        result, as is.
(define up
  (lambda (lst)
    (if (null? lst)
        '()
        (if (list? (car lst))
            (append (car lst) (up (cdr lst)))
            (cons (car lst) (up (cdr lst)))))))

;(trace up)
;(display (up-2 '((x (y)) z)))
;(display (up-2 '((1 2) (3 4))))
;(display (up '((x (y)) z)))

;;Ex1.27
;; flatten : S-list  -> Listof(Sym)
;; usage: (flatten slist) returns a list of the symbols contained in slist in
;;        the order in which they occur when slist is printed. Intuitively,
;;        flatten removes all the inner parentheses from its argument.
(define flatten
  (lambda (slist)
    (if (null? slist)
        '()
        (if (symbol? (car slist))
            (cons (car slist) (flatten (cdr slist)))
            (append (flatten (car slist)) (flatten (cdr slist)))))))
;(trace flatten)
;(flatten '((a b) c (((d)) e)))

;;Ex1.28
;; merge : Listof(Int) * Listof(Int) -> Listof(Int)
;; usage: (merge loi1 loi2), where loi1 and loi2 are lists of integers that are
;;        sorted in ascending order, returns a sorted list of all the integers
;;        in loi1 and loi2.
(define merge
  (lambda (loi1 loi2)
    (cond
      [(null? loi1) loi2]
      [(null? loi2) loi1]
      [(< (car loi2) (car loi1))
       (cons (car loi2) (merge loi1 (cdr loi2)))]
      [else (cons (car loi1) (merge (cdr loi1) loi2))])))

;(display (merge '(1 4) '(1 2 8)))
;(newline)
;(display (merge '(35 62 81 90 91) '(3 83 85 90)))
       
       