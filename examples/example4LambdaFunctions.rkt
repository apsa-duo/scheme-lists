#lang racket

;; ============================================================================
;; Example 4: Lambda Functions in Racket
;; ============================================================================
;; Illustrates how anonymous (lambda) functions work in Racket and contrasts
;; the lambda syntax with the shorthand `define` syntax.

;; --- Example 1: Doubling a number ---
;; The lambda `(lambda (x) (+ x x))` is the anonymous procedure.
;; `doubleNumber` binds a name to it for reuse.
(define doubleNumber (lambda (x) (+ x x)))
;; Usage: (doubleNumber 2)  => 4

;; --- Example 2: Adding two numbers (lambda with multiple args) ---
(define addTwoNumbers (lambda (a b) (+ a b)))
;; Usage: (addTwoNumbers 2 8)  => 10

;; --- Example 3: Average using lambda syntax ---
(define averageLambda
  (lambda (a b)
    (/ (+ a b) 2)))
;; Usage: (averageLambda 5 10)  => 15/2

;; --- Example 4: Average using shorthand define syntax ---
;; Racket's `(define (name args) body)` is syntactic sugar for the lambda form.
(define (averageShorthand a b)
  (/ (+ a b) 2))
;; Usage: (averageShorthand 5 10)  => 15/2
