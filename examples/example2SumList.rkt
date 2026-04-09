#lang racket

;; ============================================================================
;; Example 2: Recursive List Summation
;; ============================================================================
;; Demonstrates a classic recursive pattern for summing all elements of a list
;; using native Racket list operations (car, cdr, empty?).

(define sampleList (list 10 20 30 40))

;; @function sumList
;; @description Recursively sums all elements of a list.
;; @param lst - A list of numbers.
;; @returns The total sum of all elements, or 0 for an empty list.
(define (sumList lst)
  (if (empty? lst) 0
      (+ (car lst) (sumList (cdr lst)))))

;; Usage examples:
;; (sumList '(1 2 3))       => 6
;; (sumList '())            => 0
;; (sumList '(11 21 8))     => 40
;; (sumList sampleList)     => 100
