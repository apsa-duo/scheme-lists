#lang racket
(require "churchNumerals.rkt")

;; @function churchToNatural
;; @description Converts a Church natural number to a primitive decimal
(define churchToNatural (lambda (n)
      ((n add1) 0)))

;; @function churchToInteger
;; @description Converts a Church integer to a primitive integer
(define (churchToInteger i)
  (((isZeroInt i)
    (lambda (noUse) 0) ; If zero, returns 0
    (lambda (noUse)
      ((isPositiveInt i)
       (((getFirst i) add1) 0) ; If positive, converts the pos part
       (((getSecond i) sub1) 0) ; If negative, converts the neg part
      )))
   zeroNat))

;; ============================================================================
;; LISTS (Church Encoding)
;; ============================================================================

;; @function emptyList
;; @description Represents the empty list context (nil).
(define emptyList (lambda (z) z))

;; @function makeList
;; @description Constructs a list node holding an element x and a tail y.
(define makeList (lambda (x)
  (lambda (y)
  ((createPair falseChurch) ((createPair x) y)))))

;; @function isEmptyList
;; @description Returns true if the list is empty (relies on structure).
(define isEmptyList getFirst)

;; @function head
;; @description Returns the head (first value) of a list structure.
(define head (lambda (z)
   (getFirst (getSecond z))))

;; @function tail
;; @description Returns the tail of a list structure.
(define tail (lambda (z)
   (getSecond (getSecond z))))

;; @function printList
;; @description Prints a church list of integers recursively.
(define printList 
  (lambda (l) (display "[")
  ((yCombinator (lambda (f)
  (lambda (x)
  (((isEmptyList x)
    (lambda (noUse)
    (display "nil]\n")
    )
    (lambda (noUse)
    (begin
    (display (churchToInteger (head x)))
    (display ", ")
    (f (tail x))
    )
    )
  )
  zeroNat)
  )
  ))
  l)
  )
)

;; @function printInteger
;; @description Prints a single Church Integer.
(define printInteger 
  (lambda (num)
  (display (churchToInteger num))
  )
  )

;; @function printDecimal
;; @description Prints a Church Natural in decimal format.
(define printDecimal
  (lambda (num)
  (display (churchToNatural num))
  )
  )

;; ============================================================================
;; LIST ALGORITHMS
;; ============================================================================

;; @function sumListElements
;; @description Computes the sum of all elements in the given Church List.
(define sumListElements
  (lambda (l)
  ((yCombinator (lambda (f)
   (lambda (x)
    (((isEmptyList x)
    (lambda (noUse)
    intZero
    )
    (lambda (noUse)
    ((sumInt (head x))(f (tail x)))
    )
    )
    intZero)
  )
  ))
  l)
  )
)

;; @function subListElements
;; @description Computes the continuous subtraction of all elements in the Church List.
(define subListElements
  (lambda (l)
  ((yCombinator (lambda (f)
   (lambda (x)
    (((isEmptyList x)
    (lambda (noUse)
    intZero
    )
    (lambda (noUse)
    ((subtractInt (head x))(sumListElements(tail x)))
    )
    )
    intZero)
  )
  ))
  l)
  )
)

;; @function greater
;; @description Returns the greater of two Church Integers.
(define greater
  (lambda (num1)
  (lambda (num2)
  (((isGreaterInt num1) num2)
   num1
   num2)
  )
  )
  )

;; @function less
;; @description Returns the lesser of two Church Integers.
(define less
  (lambda (num1)
  (lambda (num2)
  (((isLessInt num1) num2)
   num1
   num2)
  )
  )
  )

;; @function maxElement
;; @description Finds the maximum integer element in the Church List.
(define maxElement
  (lambda (list)
  (((yCombinator (lambda (f)
     (lambda (l) 
     (lambda (currentMax)
     (((isEmptyList l)
     (lambda (noUse)
       currentMax
       )
     (lambda (noUse)
       ((f (tail l)) ((greater (head l)) currentMax))
       )
     )
    intZero)
     ))
     )
   )
  list)
   (head list))
  ))

;; @function minElement
;; @description Finds the minimum integer element in the Church List.
(define minElement
  (lambda (list)
  (((yCombinator (lambda (f)
     (lambda (l) 
     (lambda (currentMin)
     (((isEmptyList l)
     (lambda (noUse)
       currentMin
       )
     (lambda (noUse)
       ((f (tail l)) ((less (head l)) currentMin))
       )
     )
    intZero) 
     ))
     )
   )
  list)
   (head list))
  ))


;; ============================================================================
;; EXECUTION & TESTS
;; ============================================================================

;; Test Lists
(define listX ((makeList intFour)((makeList intMinusTwo)((makeList intSeven)((makeList intMinusOne)((makeList intZero)((makeList intMinusFive)emptyList)))))))

(define listY ((makeList intMinusThree)((makeList intEight)((makeList intMinusSix)((makeList intTwo)((makeList intMinusFour)((makeList intOne)emptyList)))))))

;; Test Execution
(display "=== TEST EXECUTION ===\n")

(display "List X is: ")
(printList listX)

(display "\nSum of elements in List X: ")
(printInteger (sumListElements listX))

(display "\nSubtraction block of elements in List X: ")
(printInteger (subListElements listX))

(display "\nMax element in List X: ")
(printInteger (maxElement listX))

(display "\nMin element in List X: ")
(printInteger (minElement listX))

(display "\n\nList Y is: ")
(printList listY)

(display "\nSum of elements in List Y: ")
(printInteger (sumListElements listY))

(display "\nSubtraction block of elements in List Y: ")
(printInteger (subListElements listY))

(display "\nMax element in List Y: ")
(printInteger (maxElement listY))

(display "\nMin element in List Y: ")
(printInteger (minElement listY))
(display "\n")
