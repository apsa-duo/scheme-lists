#lang racket

;; ============================================================================
;; Example 3: Safely Retrieving the First Element of a List
;; ============================================================================
;; Shows how to handle the edge case of an empty list when accessing elements.

;; @function firstElement
;; @description Returns the first element of a list, or an empty list if input is empty.
;; @param lst - A list of any type.
;; @returns The first element, or '() as the safe default.
(define (firstElement lst)
  (if (null? lst)
      '()
      (car lst)))

;; Usage examples:
;; (firstElement '(1 2 3 4))  => 1
;; (firstElement '())         => '()
