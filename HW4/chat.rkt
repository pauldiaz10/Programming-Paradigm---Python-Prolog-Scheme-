; Paul Diaz
; Homework 4 — chatbot

;;Rule 1 - done 5
;;Rule 2 - done 2
;;Rule 3 - done 1
;;Rule 4 - done 1
;;Rule 5 - done 1
;;Rule 6 - done 1
;;Rule 7 - done 2
;;Rule 8 - done 4
;;Rule 9 - done 1
;;Rule 10 - done 1
;;Rule 11 - done 1

;;; CS 152 Homework 4 - A simple chatbot
;;; starter code

;;; We'll use the random function implemented in Racket
;;; (random k) returns a random integer in the range 0 to k-1
(#%require (only racket/base random))

;;; some input and output helper functions
;;; prompt:  prompt the user for input
;;; return the input as a list of symbols
(define (prompt)
   (newline)
   (display "talk to me >>>")
   (read-line))

;;; read-line: read the user input till the eof character
;;; return the input as a list of symbols
(define (read-line)
  (let ((next (read)))
    (if (eof-object? next)
        '()
        (cons next (read-line)))))

;;; output: take a list such as '(how are you?) and display it
(define (output lst)
       (display (to-string lst)))

;;; to-string: convert a list such as '(how are you?)
;;; to the string  "how are you?"
(define (to-string lst)       
  (cond ((null? lst) "")
        ((eq? (length lst) 1) (symbol->string (car lst)))
        (else (string-append (symbol->string (car lst))
                              " "
                             (to-string (cdr lst))))))
;;;  main function
;;;  usage:  (chat-with 'your-name)
(define (chat-with name)
  (output (list 'hi name))
  (newline)
  (chat-loop name))

;;; chat loop
(define (chat-loop name)
  (let ((input (prompt))) ; get the user input
    (if (equal? (car input) 'bye)
        (begin
          (newline)
          (output (list 'bye name))
          (newline)
          (output (list 'have 'a 'great 'day!))
          (newline))
        (begin
          (reply input name)
          (chat-loop name)))))

;  ((in? "because" input) (newline (display "is that the real reason?"))); Rule #7
;;; your task is to fill in the code for the reply function
;;; to implement rules 1 through 11 with the required priority
;;; each non-trivial rule must be implemented in a separate function
;;; define any helper functions you need below
(define (reply input name)
  (define rule2Pro (set '(family friend friends mom dad brother sister girlfriend boyfriend children son daughter child wife husband home dog cat pet)))
  (list? rule2Pro)
  (define inter(intersection rule2Pro input))
  (cond
        ((equal? (car input) 'why) (newline) (display "why not?")(newline)); RULE #3
        ((equal? (car input) 'how) (newline) (output (pick-random how-response))(newline)); RULE #4
        ((equal? (car input) 'what) (newline) (output (pick-random what-response))(newline)); RULE #5
        (else
          (cond
            ((in? (symbol->string(car input)) (set'("do" "can" "will" "would")))(rule-one-response name input)); RULE #1
            (else
             (cond
               ((in? 'because input) (newline)(display "is that the real reason?") (newline)); Rule #7
               (else
                (cond
                  ((not (null? (intersection rule2Pro input)))(rule-two-response name input inter)); Rule #2
                   (else
                   (cond
                     ((and (equal? (car input) 'i) (not (in? (symbol->string(car(cdr input))) (set'("need" "think" "have" "want")))) (not (in? 'too input)))(newline)(rule-nine-response name input)(newline)); Rule #9
                     (else
                      (cond
                        ((or (equal? (car input) 'is) (equal? (car input) 'are))(newline)(output (pick-random rule-six-response-choices))(newline)); RULE #6
                        (else
                         (cond
                           ((in? (symbol->string(car input)) (set '("tell" "give" "say")))(newline)(display "you ") (output input)(newline)); Rule #10
                           (else
                            (cond
                              ((and (equal? (car input) 'i) (not (in? 'too input)) (in? (symbol->string(car(cdr input))) (set'("need" "think" "have" "want"))))(rule-eight-response name input)); RULE #8
                              ((newline)(output (pick-random generic-response))(newline))))))))))))))))))

;;; pick one random element from the list choices
(define (pick-random choices)
  (list-ref choices (random (length choices))))

;;; rule 2 implementation
(define (rule-two-response name input inter)
  (define rand(pick-random inter))
  (newline)
  (display "tell more about your ")
  (display rand)
  (display " ")
  (display name)
  (newline))

;;; rule 8 implementation
(define (rule-eight-response name input)
  (define a(find-replace 'i 'you input))
  (string? a)
  (cond
    ((in? 'my a) (newline) (display "why do ") (output (find-replace 'my 'your a))(display "?") (newline));umbrella
    ((in? 'your a) (newline) (display "why do ")(output (find-replace 'your 'my a)) (display "?")(newline));algorithm
    ((in? 'am a) (newline)(display "why do you ") (output (find-replace 'you 'you\'re (cdr (deleteItem a 'am))))(display "?")(newline));i am done
    ((newline)(display "why do ") (output(find-replace 'you 'me (find-replace 'am 'you a))) (display "?")(newline))))


;;; rule 9 implementation
(define (rule-nine-response name input)
  (cond
    ((and (equal? (car input) 'i) (equal? (car (cdr input)) 'am))(output input)(display " too"))
    ((output input) (display " too"))))

;;; rule 1 implementation
(define (rule-one-response name input)
  (define answer (pick-random yes-no-response))
  (define first (car input))

  (define tempinput (remove-last (cddr input)))  
  (define lastinput (lastt (cddr input)))
 
  (define last (substring (to-string (lastt (cddr input))) 0 (- (string-length (to-string (lastt (cddr input)))) 1)))
  (string? last)

  (define temp (add-to-end tempinput last))
  (define g (list 'no name 'i (car input) 'not))
  (define h (find-replace 'me 'you tempinput))
  (define i (find-replace 'my 'your h))
  (newline)
  (cond
    ((equal? (symbol->string(car answer)) "yes")(display (string-append "yes i " (symbol->string(car input)))) (newline))
    (else
     (cond
       ((and (in? 'me input) (in? 'my input))(newline)(output g) (display " ")(output i)(display " ")(display last)(newline))
       ((in? 'me? input)(output g) (display " ")(output tempinput) (display " ") (display "you")(newline))
       ((output g) (display " ")(output tempinput) (display " ") (display last)(newline))))))

;;; rule 6 responses
(define rule-six-response-choices '((i don\'t know)
                                    (i have no idea)
                                    (i have no clue)
                                    (maybe)))
;;; yes and no responses
(define yes-no-response '((yes)
                          (no)))
;;; how response for rule 4
(define how-response '((why do you ask?)
                       (how would an answer to that help you?)))

;;; what response for rule 5
(define what-response '((what do you think?)
                       (why do you ask?)))

;;; generic responses for rule 11
(define generic-response '((that\'s nice)
                           (good to know)
                           (can you elaborate on that?)))

;;;;;;;;;;;;;;;;;;;;;;;;;;; HELPER FUNCTIONS

;return a list representation of a set where each element appears once.  The order is not relevant.
(define (set s)
  (cond ((null? s) (list)); empty list
     ((member (car s )(cdr s))
      (set (cdr s)))
        (else (cons (car s) (set (cdr s)))))
)
;return #t if s is an empty set and #f otherwise.
(define (empty? s)
  (null? s)
)
;return #t if the element e is in the set s, #f otherwise.
(define (in? e s)
  (cond ((empty? s) #f)
        ((equal? e (car s)) #t)
        (else (in? e (cdr s))))
)
;remove the last element in the list
(define (remove-last lst)
    (if (null? (cdr lst))
        '()
        (cons (car lst) (remove-last (cdr lst)))))
;returns the last element in the list
(define (lastt lst)
  (if (= (length lst) 1)
      lst
      (lastt (cdr lst))))
;return a new set that contains all the elements in s and the element e.
(define (add e s)
  (cond ((not (in? e s)) (cons e s))
        (else (if (in? e s) s))))
;adds a new element at the end of the list
(define (add-to-end lst e) 
   (if (null? lst) 
       (list e)
       (cons (car lst)
             (add-to-end (cdr lst) e))))
;it finds the "a" element and replace it with the value of b in the list
(define (find-replace a b list)
 (cond
  ((null? list) '())
  ((list? (car list)) (cons (find-replace a b (car list)) (find-replace a b (cdr list))))
  ((eq? (car list) a) (cons b (find-replace a b (cdr list))))
  (else
   (cons (car list) (find-replace a b (cdr list))))))
;deletes the item in the list
(define (deleteItem lst item)
  (cond ((null? lst)
         '())
        ((equal? item (car lst))
         (cdr lst))
        (else
         (cons (car lst) 
               (deleteItem (cdr lst) item)))))
;return a new set that contains all the elements that appear in both sets.
(define (intersection s1 s2)
  (cond ((empty? s1) (list))
       ((empty? s2) (list))
       (else
        (if (not(in? (car s1) s2))
            (intersection s2 (cdr s1))
            (cons (car s1) (intersection (cdr s1) s2)))))
)
;return a new set with elements in either s1 or s2 but not both.
(define (symmetric-difference s1 s2)
  (cond ((empty? s1) s2)
        ((empty? s2) s1)
        ((union (difference s1 s2) (difference s2 s1))))
)
(chat-with 'Paul)









