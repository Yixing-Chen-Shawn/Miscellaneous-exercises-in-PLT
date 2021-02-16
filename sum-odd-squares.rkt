#lang racket
(require racket/trace)

(define (sum-odd-squares tree)
  (cond 
	[(null? tree) 0]
	[(not (pair? tree))
	 ;; if is a filter to allow signal to pass through
	 (if (odd? tree)
		 ;; the resulting signal is in turn passed through map. 
		 ;; a "transducer" that applies the square procedure to
		 ;; each of element in the tree (just a list in reality) 
		 (sqr tree)
		 0)]
	[else
	  ;; an accumulator which combines the elements using +
	  ;; starting from an initial 0 returned from null tree
	  (+ (sum-odd-squares (car tree))
		 ;; (sum-odd-squares tree) is basically a enumerator 
		 ;; for generating "signal" consisting of the leaves of tht tree
		 (sum-odd-squares (cdr tree)))]))
(define tree (list (list 1 2) 3 4))
(trace sum-odd-squares)
(sum-odd-squares tree)


;; take away for the code above by understanding the signal-flow structure:

;; if we examine the sum-odd-squares procedure, we find that the enumeration is implemented partly by the null? and pair? tests and partly by the tree-recursive structure of the procedure. Similarly, the accumulation is found partly in the tests and partly in the addition used in the recursion. In general, there are no distinct parts of either procedure that correspond to the elements in the signal-flow description. Our two procedures decompose the computa- tions in a different way, spreading the enumeration over the program and mingling it with the map, the filter, and the accumulation. If we could organize our programs to make the signal-flow structure manifest in the procedures we write, this would increase the conceptual clarity of the resulting code.
