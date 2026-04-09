#lang racket

;; ============================================================================
;; Example 1: Working with Pairs in Racket
;; ============================================================================
;; This file demonstrates the native Racket pair (`cons`) data structure,
;; which is the foundational building block for lists in Scheme/Racket.

;; --- Basic Arithmetic ---
(define sumResult (+ 2 3))

;; --- Simple Pair ---
;; A pair bundles two values together using `cons`.
(define shoePair (cons "left" "right"))
(car shoePair)  ; Returns "left"   (first element)
(cdr shoePair)  ; Returns "right"  (second element)

;; --- Nested Pairs ---
;; Pairs can be nested to build more complex structures (e.g., trees).
(define nestedPair
  (cons (cons 1 2)
        (cons 3 4)))

;; (car (car nestedPair))  => 1
;; (cdr (car nestedPair))  => 2
;; (car (cdr nestedPair))  => 3
;; (cdr (cdr nestedPair))  => 4
