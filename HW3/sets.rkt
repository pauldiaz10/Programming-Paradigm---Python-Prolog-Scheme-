;Paul Diaz
;CS152 Homework 3 - Scheme Programming
;San Jose State University

;return #t if s is an empty set and #f otherwise.
(define (empty? s)
  (null? s)
)
;return a list representation of a set where each element appears once.  The order is not relevant.
(define (set s)
  (cond ((null? s) (list)); empty list
     ((member (car s )(cdr s))
      (set (cdr s)))
        (else (cons (car s) (set (cdr s)))))
)
;return #t if the element e is in the set s, #f otherwise.
(define (in? e s)
  (cond ((empty? s) #f)
        ((equal? e (car s)) #t)
        (else (in? e (cdr s))))
)
;return a new set that contains all the elements in s and the element e.
(define (add e s)
  (cond ((not (in? e s)) (cons e s))
        (else (if (in? e s) s)))
)
;return a new set that contains all the elements in s other than e.  If e is not in s, discard returns s.
(define (discard e s)
  (cond ((empty? s) (list))
        ((eq? e (car s)) (discard e (cdr s)))
        (else (cons (car s) (discard e (cdr s)))))
)
;return a new set that contains all the elements in s1 and all the elements of s2.  The new set does not contain duplicates.
(define (union s1 s2)
  (cond ((empty? s1) s2)
     ((empty? s2) s1)
     (else
      (set (append s1 s2))))
)
;return a new set that contains all the elements that appear in both sets.
(define (intersection s1 s2)
  (cond ((empty? s1) (list))
       ((empty? s2) (list))
       (else
        (if (not(in? (car s1) s2))
            (intersection s2 (cdr s1))
            (cons (car s1) (intersection (cdr s1) s2)))))
)
;return a new set that contains all the elements in s1 that are not in s2.
(define (difference s1 s2)
  (cond ((empty? s1) (list))
         ((not (in? (car s1) s2))(cons (car s1) (difference (cdr s1) s2)))
         (else (difference (cdr s1) s2)))
)
;return a new set with elements in either s1 or s2 but not both.
(define (symmetric-difference s1 s2)
  (cond ((empty? s1) s2)
        ((empty? s2) s1)
        ((union (difference s1 s2) (difference s2 s1))))
)
;return #t if every element of s1 is in s2, #f otherwise.
(define (subset? s1 s2)
   (or
    (<= (length s1) 1)
    (and
     (in? (car s1) s2)(subset? (cdr s1) s2)))
)
;return #t if every element of s2 is in s1, #f otherwise.          
(define (superset? s1 s2)
  (cond ((empty? s1) #f)
        ((empty? s2) #f)
        ((not (in? (car s2) s1)) #f)
        (else
         (empty? (difference s2 s1))))
)
;return #t if s1 and s2 have no elements in common, #f otherwise.
(define (disjoint? s1 s2)
  (cond ((empty? s1) #f)
        ((empty? s2) #f)
        (else
         (if (empty?(intersection s1 s2)) #t #f)))
)
;return #t if s1 and s2 have the same elements, #f otherwise.  The order is not relevant.
(define (sameset? s1 s2)
  (cond ((empty? s1) #f)
        ((empty? s2) #f)
        ((not (in? (car s1) s2)) #f)
        (else
         (empty? (difference s1 s2))))
)
;some tests
(define A (set '(1 2 7 9 7 1)))
(define B (set '(2 0 8 0 7 12)))
(define C (set '(9 7)))
(define D (set '(1 1)))

(define colors (set '("yellow" "red" "green" "blue" "orange" "purple" "pink" "red")))
(define rgb (set '("red" "blue" "green" "red" "green" "blue")))
(define hi (set '(#\h #\i)))

(empty? A) ; #f
(empty? rgb) ;#f
(empty? (set'())) ;#t

(in? 0 A) ; #f
(in? "red" A); #f
(in? 2 A) ; #t

(in? "green" rgb) ; #t
(in? "purple" rgb) ; #f
(in? "i" hi) ;#f
(in? #\i hi) ;#t

(add 9 A) ; (2 9 7 1)
(add 5 A) ; (5 2 9 7 1)

(discard 1 A) ; (2 9 7)
(discard 5 A) ; (2 9 7 1)
(union A B) ; (9 1 2 8 0 7 12)
(union A rgb) ; (2 9 7 1 "red" "green" "blue")

(intersection A rgb) ; ()
(intersection A B) ; (2 7)
(intersection rgb colors) ; ("red" "green" "blue")

(difference A B) ; (9 1)
(difference rgb colors) ; ()
(difference colors rgb) ; ("yellow" "orange" "purple" "pink")

(symmetric-difference A B) ; (9 1 8 0 12)
(symmetric-difference A C) ; (2 1)
(symmetric-difference colors rgb) ; ("yellow" "orange" "purple" "pink")

(subset? A B) ;#f
(subset? C A) ; #t

(subset? colors rgb) ;#f
(subset? rgb colors)  ; #t

(superset? A B) ;#f
(superset?  A C) ; #t

(superset? colors rgb) ;#t
(superset? rgb colors)  ; #f

(disjoint? B C) ;#f
(disjoint? colors A) ;#t

(sameset? (set '(9 1 2 7)) A); #t
(sameset? B A) ; #f