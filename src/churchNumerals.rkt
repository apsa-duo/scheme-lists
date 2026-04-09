#lang racket
(provide (all-defined-out))

;; ============================================================================
;; BOOLEANS (Church Encoding)
;; ============================================================================

;; @function trueChurch
;; @description Church representation of True. Takes two arguments and returns the first.
(define trueChurch (lambda (x y) x))

;; @function falseChurch
;; @description Church representation of False. Takes two arguments and returns the second.
(define falseChurch (lambda (x y) y))

;; @function notChurch
;; @description Logical NOT for Church booleans.
(define notChurch (lambda (x) (x falseChurch trueChurch)))

;; @function andChurch
;; @description Logical AND for Church booleans. (returns falseChurch if x is falseChurch)
(define andChurch (lambda (x y) (x y falseChurch)))

;; @function orChurch
;; @description Logical OR for Church booleans.
(define orChurch (lambda (x y) (x trueChurch y)))

;; ============================================================================
;; PAIRS (Church Encoding)
;; ============================================================================

;; @function createPair
;; @description Creates an ordered pair of two elements (x, y).
(define createPair
  (lambda (x)
    (lambda (y)
      (lambda (f) (f x y)))))

;; @function getFirst
;; @description Returns the first element of a pair.
(define getFirst (lambda (p) (p trueChurch)))

;; @function getSecond
;; @description Returns the second element of a pair.
(define getSecond (lambda (p) (p falseChurch)))

;; ============================================================================
;; Y-COMBINATOR (Fixed-Point Combinator)
;; ============================================================================

;; @function yCombinator
;; @description Enables recursion within anonymous lambda functions.
(define yCombinator
  (lambda (f)
    ((lambda (x) (f (lambda (v) ((x x) v))))
     (lambda (x) (f (lambda (v) ((x x) v)))))))

;; ============================================================================
;; NATURAL NUMBERS API (Church Encoding)
;; ============================================================================
;; Natural numbers are represented as n successive applications of a function (f)
;; to a given value (x). Zero is applying the function 0 times (returning x).

;; @function isLessOrEqualNat
(define isLessOrEqualNat
  (lambda (n)
    (lambda (m)
      (isZeroNat ((subtractNat n) m)))))

;; @function isGreaterOrEqualNat
(define isGreaterOrEqualNat
  (lambda (n)
    (lambda (m)
      (isZeroNat ((subtractNat m) n)))))

;; @function isLessNat
(define isLessNat
  (lambda (n)
    (lambda (m)
      (andChurch ((isLessOrEqualNat n) m) (isNotZeroNat ((subtractNat m) n))))))

;; @function isGreaterNat
(define isGreaterNat
  (lambda (n)
    (lambda (m)
      (andChurch ((isGreaterOrEqualNat n) m) (isNotZeroNat ((subtractNat n) m))))))

;; @function isEqualNat
(define isEqualNat
  (lambda (n)
    (lambda (m)
      (andChurch ((isGreaterOrEqualNat n) m) ((isLessOrEqualNat n) m)))))

;; @function isZeroNat
(define isZeroNat
  (lambda (n)
    ((n (lambda (x) falseChurch)) trueChurch)))

;; @function isNotZeroNat
(define isNotZeroNat
  (lambda (n)
    (notChurch (isZeroNat n))))

;; --- Basic Arithmetic Base ---

;; @function zeroNat
(define zeroNat
  (lambda (f)
    (lambda (x) x)))

;; @function successorNat
(define successorNat
  (lambda (n)
    (lambda (f)
      (lambda (x)
        (f ((n f) x))))))

;; Number definitions (1 to 20)
(define oneNat (successorNat zeroNat))
(define twoNat (successorNat oneNat))
(define threeNat (successorNat twoNat))
(define fourNat (successorNat threeNat))
(define fiveNat (successorNat fourNat))
(define sixNat (successorNat fiveNat))
(define sevenNat (successorNat sixNat))
(define eightNat (successorNat sevenNat))
(define nineNat (successorNat eightNat))
(define tenNat (successorNat nineNat))
(define elevenNat (successorNat tenNat))
(define twelveNat (successorNat elevenNat))
(define thirteenNat (successorNat twelveNat))
(define fourteenNat (successorNat thirteenNat))
(define fifteenNat (successorNat fourteenNat))
(define sixteenNat (successorNat fifteenNat))
(define seventeenNat (successorNat sixteenNat))
(define eighteenNat (successorNat seventeenNat))
(define nineteenNat (successorNat eighteenNat))
(define twentyNat (successorNat nineteenNat))

;; @function checkNatToDecimal
;; @description Converts a Church natural number to a primitive Racket integer for easy checking.
(define checkNatToDecimal
  (lambda (n)
    ((n (lambda (x) (+ 1 x))) 0)))

;; @function sumNat
(define sumNat
  (lambda (n)
    (lambda (m)
      ((n (lambda (x) (successorNat x))) m))))

;; @function multiplyNat
(define multiplyNat
  (lambda (n)
    (lambda (m)
      (lambda (f)
        (lambda (x) ((m (n f)) x))))))

;; @function predecessorHelper
;; @description Helper function to compute the predecessor.
(define predecessorHelper
  (lambda (f)
    (lambda (p)
      ((createPair (f (getFirst p))) (getFirst p)))))

;; @function predecessorNat
;; @description Returns n-1 for a Church Natural number. Returns zeroNat if n is zeroNat.
(define predecessorNat
  (lambda (n)
    (lambda (f)
      (lambda (x)
        (getSecond ((n ((lambda (g)
                          (lambda (p) ((predecessorHelper g) p))) f)) ((createPair x) x)))))))

;; @function subtractNat
(define subtractNat
  (lambda (n)
    (lambda (m)
      ((m (lambda (x) (predecessorNat x))) n))))

;; @function remainderNatHelper
(define remainderNatHelper
  (lambda (n)
    (lambda (m)
      ((yCombinator
        (lambda (f)
          (lambda (x)
            ((((isGreaterOrEqualNat x) m)
              (lambda (noUse) (f ((subtractNat x) m)))
              (lambda (noUse) x))
             zeroNat))))
       n))))

;; @function remainderNat
;; @description Returns the remainder of n / m. If m is zero, it returns falseChurch.
(define remainderNat
  (lambda (n)
    (lambda (m)
      (((isZeroNat m)
        (lambda (noUse) falseChurch)
        (lambda (noUse) ((remainderNatHelper n) m)))
       zeroNat))))

;; @function quotientNatHelper
(define quotientNatHelper
  (lambda (n)
    (lambda (m)
      ((yCombinator
        (lambda (f)
          (lambda (x)
            ((((isGreaterOrEqualNat x) m)
              (lambda (noUse) (successorNat (f ((subtractNat x) m))))
              (lambda (noUse) zeroNat))
             zeroNat))))
       n))))

;; @function quotientNat
;; @description Returns the integer division of n by m.
(define quotientNat
  (lambda (n)
    (lambda (m)
      (((isZeroNat m)
        (lambda (noUse) falseChurch)
        (lambda (noUse) ((quotientNatHelper n) m)))
       zeroNat))))

;; @function gcdNat
;; @description Computes the Greatest Common Divisor of two natural numbers.
(define gcdNat
  (lambda (n)
    (lambda (m)
      (((yCombinator
         (lambda (f)
           (lambda (x)
             (lambda (y)
               (((isZeroNat y)
                 (lambda (noUse) x)
                 (lambda (noUse) ((f y) ((remainderNat x) y))))
                zeroNat)))))
        n) m))))

;; ============================================================================
;; INTEGER NUMBERS API (Church Encoding)
;; ============================================================================
;; Integers are represented as an ordered pair of natural numbers (p, n) where:
;; Value = p - n (positive and negative components).

;; Some integers initialization
(define intZero ((createPair zeroNat) zeroNat))

(define intMinusOne ((createPair zeroNat) oneNat))
(define intMinusTwo ((createPair zeroNat) twoNat))
(define intMinusThree ((createPair zeroNat) threeNat))
(define intMinusFour ((createPair zeroNat) fourNat))
(define intMinusFive ((createPair zeroNat) fiveNat))
(define intMinusSix ((createPair zeroNat) sixNat))
(define intMinusSeven ((createPair zeroNat) sevenNat))
(define intMinusEight ((createPair zeroNat) eightNat))
(define intMinusNine ((createPair zeroNat) nineNat))
(define intMinusTen ((createPair zeroNat) tenNat))
(define intMinusEleven ((createPair zeroNat) elevenNat))
(define intMinusTwelve ((createPair zeroNat) twelveNat))
(define intMinusThirteen ((createPair zeroNat) thirteenNat))
(define intMinusFourteen ((createPair zeroNat) fourteenNat))
(define intMinusFifteen ((createPair zeroNat) fifteenNat))
(define intMinusSixteen ((createPair zeroNat) sixteenNat))
(define intMinusSeventeen ((createPair zeroNat) seventeenNat))
(define intMinusEighteen ((createPair zeroNat) eighteenNat))
(define intMinusNineteen ((createPair zeroNat) nineteenNat))
(define intMinusTwenty ((createPair zeroNat) twentyNat))

(define intOne ((createPair oneNat) zeroNat))
(define intTwo ((createPair twoNat) zeroNat))
(define intThree ((createPair threeNat) zeroNat))
(define intFour ((createPair fourNat) zeroNat))
(define intFive ((createPair fiveNat) zeroNat))
(define intSix ((createPair sixNat) zeroNat))
(define intSeven ((createPair sevenNat) zeroNat))
(define intEight ((createPair eightNat) zeroNat))
(define intNine ((createPair nineNat) zeroNat))
(define intTen ((createPair tenNat) zeroNat))
(define intEleven ((createPair elevenNat) zeroNat))
(define intTwelve ((createPair twelveNat) zeroNat))
(define intThirteen ((createPair thirteenNat) zeroNat))
(define intFourteen ((createPair fourteenNat) zeroNat))
(define intFifteen ((createPair fifteenNat) zeroNat))
(define intSixteen ((createPair sixteenNat) zeroNat))
(define intSeventeen ((createPair seventeenNat) zeroNat))
(define intEighteen ((createPair eighteenNat) zeroNat))
(define intNineteen ((createPair nineteenNat) zeroNat))
(define intTwenty ((createPair twentyNat) zeroNat))

;; @description Integer Comparison API
(define isGreaterOrEqualInt
  (lambda (r)
    (lambda (s)
      ((isGreaterOrEqualNat ((sumNat (getFirst r)) (getSecond s)))
       ((sumNat (getFirst s)) (getSecond r))))))

(define isLessOrEqualInt
  (lambda (r)
    (lambda (s)
      ((isLessOrEqualNat ((sumNat (getFirst r)) (getSecond s)))
       ((sumNat (getFirst s)) (getSecond r))))))

(define isGreaterInt
  (lambda (r)
    (lambda (s)
      ((isGreaterNat ((sumNat (getFirst r)) (getSecond s)))
       ((sumNat (getFirst s)) (getSecond r))))))

(define isLessInt
  (lambda (r)
    (lambda (s)
      ((isLessNat ((sumNat (getFirst r)) (getSecond s)))
       ((sumNat (getFirst s)) (getSecond r))))))

(define isEqualInt
  (lambda (r)
    (lambda (s)
      ((isEqualNat ((sumNat (getFirst r)) (getSecond s)))
       ((sumNat (getFirst s)) (getSecond r))))))

;; @function absoluteInt
(define absoluteInt
  (lambda (r)
    (((isGreaterOrEqualNat (getFirst r)) (getSecond r))
     ((createPair ((subtractNat (getFirst r)) (getSecond r))) zeroNat)
     ((createPair ((subtractNat (getSecond r)) (getFirst r))) zeroNat))))

(define isNegativeInt
  (lambda (r)
    ((isLessInt r) intZero)))

(define isPositiveInt
  (lambda (r)
    ((isGreaterInt r) intZero)))

(define isZeroInt
  (lambda (r)
    ((isEqualNat (getFirst r)) (getSecond r))))

(define isNotZeroInt
  (lambda (r)
    (notChurch (isZeroInt r))))

;; @function reduceInt
;; @description Minimizes an integer representation to its canonical equivalence class form.
(define reduceInt
  (lambda (r)
    (((isGreaterOrEqualNat (getFirst r)) (getSecond r))
     ((createPair ((subtractNat (getFirst r)) (getSecond r))) zeroNat)
     ((createPair zeroNat) ((subtractNat (getSecond r)) (getFirst r))))))

;; @function checkIntToDecimal
(define checkIntToDecimal
  (lambda (r)
    (- (checkNatToDecimal (getFirst r)) (checkNatToDecimal (getSecond r)))))

;; @function sumInt
(define sumInt
  (lambda (r)
    (lambda (s)
      (reduceInt ((createPair ((sumNat (getFirst r)) (getFirst s)))
                  ((sumNat (getSecond r)) (getSecond s)))))))

;; @function multiplyInt
(define multiplyInt
  (lambda (r)
    (lambda (s)
      (reduceInt ((createPair ((sumNat ((multiplyNat (getFirst r)) (getFirst s))) ((multiplyNat (getSecond r)) (getSecond s))))
                  ((sumNat ((multiplyNat (getFirst r)) (getSecond s))) ((multiplyNat (getSecond r)) (getFirst s))))))))

;; @function subtractInt
(define subtractInt
  (lambda (r)
    (lambda (s)
      (reduceInt ((createPair ((sumNat (getFirst r)) (getSecond s)))
                  ((sumNat (getSecond r)) (getFirst s)))))))

;; @description Integer Division components
(define quotientIntHelperAux
  (lambda (r)
    (lambda (s)
      ((quotientNat (getFirst (absoluteInt r))) (getFirst (absoluteInt s))))))

(define quotientIntHelperCase1
  (lambda (r)
    (lambda (s)
      ((orChurch (andChurch ((isGreaterOrEqualInt r) intZero) (isPositiveInt s))
                 (andChurch (isNegativeInt r) (isNegativeInt s)))
       ((createPair ((quotientNat (getFirst (absoluteInt r))) (getFirst (absoluteInt s)))) zeroNat)
       ((createPair zeroNat) ((quotientNat (getFirst (absoluteInt r))) (getFirst (absoluteInt s))))))))

(define quotientIntHelperCase2
  (lambda (r)
    (lambda (s)
      (((isGreaterOrEqualInt r) intZero)
       ((isPositiveInt s) ((createPair ((quotientIntHelperAux r) s)) zeroNat) ((createPair zeroNat) ((quotientIntHelperAux r) s)))
       ((isPositiveInt s) ((createPair zeroNat) (successorNat ((quotientIntHelperAux r) s))) ((createPair (successorNat ((quotientIntHelperAux r) s))) zeroNat))))))

(define quotientIntHelper
  (lambda (r)
    (lambda (s)
      ((isZeroNat ((remainderNat (getFirst (absoluteInt r))) (getFirst (absoluteInt s))))
       ((quotientIntHelperCase1 r) s)
       ((quotientIntHelperCase2 r) s)))))

(define quotientInt
  (lambda (r)
    (lambda (s)
      (((isZeroInt s)
        (lambda (noUse) falseChurch)
        (lambda (noUse) ((quotientIntHelper r) s)))
       zeroNat))))

(define remainderIntHelper1
  (lambda (r)
    (lambda (s)
      ((orChurch (andChurch ((isGreaterOrEqualInt r) intZero) (isPositiveInt s))
                 (andChurch ((isGreaterOrEqualInt r) intZero) (isNegativeInt s)))
       ((createPair ((remainderNat (getFirst (absoluteInt r))) (getFirst (absoluteInt s)))) zeroNat)
       ((createPair ((subtractNat (getFirst (absoluteInt s))) ((remainderNat (getFirst (absoluteInt r))) (getFirst (absoluteInt s))))) zeroNat)))))

(define remainderIntHelper
  (lambda (r)
    (lambda (s)
      ((isZeroNat ((remainderNat (getFirst (absoluteInt r))) (getFirst (absoluteInt s))))
       intZero
       ((remainderIntHelper1 r) s)))))

(define remainderInt
  (lambda (r)
    (lambda (s)
      (((isZeroInt s)
        (lambda (noUse) falseChurch)
        (lambda (noUse) ((remainderIntHelper r) s)))
       zeroNat))))

(define gcdInt
  (lambda (r)
    (lambda (s)
      ((createPair ((gcdNat (getFirst (absoluteInt r))) (getFirst (absoluteInt s)))) zeroNat))))
