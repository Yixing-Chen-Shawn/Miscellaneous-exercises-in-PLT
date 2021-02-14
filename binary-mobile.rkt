#lang racket
(require racket/trace)

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cadr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cadr branch))

;; calculate the sum of left and right branch 
(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
	 (branch-weight (right-branch mobile))))

;; if one branch is hanging another mobile, then the total wiehgt of mobile 
;; is the weight of the branch. otherwise, the structure part of branch
;; is the weight of the branch
(define (branch-weight branch)
  (if (hangs-another-mobile? branch)
	  (total-weight (branch-structure branch))
	  (branch-structure branch)))

(define (hangs-another-mobile? branch)
  (pair? (branch-structure branch)))

(define mobile (make-mobile (make-branch 10 20)       ; 活动体的总重量为 20 + 25 = 45
							(make-branch 10 25)))

(define another-mobile (make-mobile (make-branch 10 mobile)   ; 左分支吊着另一个活动体，总重为 45
									(make-branch 10 20)))     ; 右分支的重量是 20

;; examine if a binary mobile is balanced.
;; multiply of length and the weight hanging from that rod is torque
(define (branch-torque branch)
  (* (branch-length branch)
	 (branch-weight branch)))

;; firstly the left branch and right branch must have the same torque
;; then recursivly check if submobiles are all balanced or not.
(define (mobile-balance? mobile)
  (let ([left (left-branch mobile)]
		[right (right-branch mobile)])
	(and
	  (same-torque? left right)
	  (branch-balance? left)
	  (branch-balance? right))))

(define (same-torque? left right)
  (= (branch-torque left)
	 (branch-torque right)))

(define (branch-balance? branch)
  (if (hangs-another-mobile? branch)
	  (mobile-balance? (branch-structure branch))
	  #t))

(trace total-weight)
(trace branch-length)
(trace branch-weight)
(trace left-branch)
(trace right-branch)
(trace hangs-another-mobile?)
(trace branch-structure)
(trace branch-torque)
(trace mobile-balance?)
(trace same-torque?)
(trace branch-balance?)
(define balanced-mobile (make-mobile (make-branch 10 10)
									 (make-branch 10 10)))
(define unbalanced-mobile (make-mobile (make-branch 0 0)
									   (make-branch 10 10)))

(mobile-balance? unbalanced-mobile)
