#lang racket

(define (parens-match? s [i 0] [n 0])
  (cond
    [(eq? i (string-length s))
     (eq? n 0)]
    [(eq? #\( (string-ref s i))
     (parens-match? s (+ i 1) (+ n 1))]
    [(eq? #\) (string-ref s i))
     (and (> n 0)
          (parens-match? s (+ i 1) (- n 1)))]
    [else
     (parens-match? s (+ i 1) n)]))

(define (brackets-match? s [i 0] [stack null])
  (cond
    [(eq? i (string-length s))
     (eq? stack null)]
    [(eq? #\( (string-ref s i))
     (brackets-match? s (+ i 1) (cons #\( stack))]
    [(eq? #\) (string-ref s i))
     (and (cons? stack)
          (eq? #\( (car stack))
          (brackets-match? s (+ i 1) (cdr stack)))]
    [(eq? #\[ (string-ref s i))
     (brackets-match? s (+ i 1) (cons #\[ stack))]
    [(eq? #\] (string-ref s i))
     (and (cons? stack)
          (eq? #\[ (car stack))
          (brackets-match? s (+ i 1) (cdr stack)))]
    [(eq? #\{ (string-ref s i))
     (brackets-match? s (+ i 1) (cons #\{ stack))]
    [(eq? #\} (string-ref s i))
     (and (cons? stack)
          (eq? #\{ (car stack))
          (brackets-match? s (+ i 1) (cdr stack)))]
    [else
     (brackets-match? s (+ i 1) stack)]))

(define (tests)
  (and
    (parens-match? "")
    (not (parens-match? "("))
    (not (parens-match? ")"))
    (parens-match? "()")
    (parens-match? "([)]")
    (not (brackets-match? "([)]"))
    (brackets-match? "([])")
    (not (parens-match? "sdfvdsf(sdfvs)fdvsf)sdfv(dsfv"))
    (brackets-match? "--(++++)----")
    (brackets-match? "before ( middle []) after")
    (brackets-match? "([<>()]<>)")))
