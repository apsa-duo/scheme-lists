<p align="center">
  <img src="https://img.shields.io/badge/version-v1.0.0-blue?style=for-the-badge" alt="Version"/>
  <img src="https://img.shields.io/badge/status-Maintained-brightgreen?style=for-the-badge" alt="Status"/>
  <img src="https://img.shields.io/badge/license-MIT-orange?style=for-the-badge" alt="License"/>
</p>

# λ Church Numerals — Pure Lambda Calculus Arithmetic in Racket

> **Building numbers, arithmetic, and data structures from nothing but functions.**

A complete implementation of [Church Encoding](https://en.wikipedia.org/wiki/Church_encoding) in Racket that constructs the entire integer number system — booleans, natural numbers, integers, ordered pairs, and linked lists — using **only anonymous lambda functions**, without relying on any built-in numeric primitives.

---

## 📌 The Problem It Solves

Most programmers take numbers and operators for granted. But can you build `+`, `-`, `×`, `÷`, `max`, `min`, and even `gcd` **from scratch**, using nothing but function application?

This project proves you can. It is a hands-on, executable demonstration of the theoretical foundations of computation as described by [Alonzo Church](https://en.wikipedia.org/wiki/Alonzo_Church) in the 1930s — implemented in a modern functional language.

---

## 🛠️ Tech Stack

| Technology | Purpose |
|:--:|:--|
| ![Racket](https://img.shields.io/badge/Racket-9F1D20?style=flat-square&logo=racket&logoColor=white) | Core implementation language (Scheme dialect) |
| ![Lambda Calculus](https://img.shields.io/badge/λ_Calculus-Theory-blueviolet?style=flat-square) | Computational model for all encodings |
| ![Git](https://img.shields.io/badge/Git-F05032?style=flat-square&logo=git&logoColor=white) | Version control |

---

## ✨ Key Features

- **Church Booleans** — `true`, `false`, `and`, `or`, `not` encoded as pure lambda selectors.
- **Church Numerals (Naturals)** — Numbers 0–20 built via iterated function application.
- **Full Natural Arithmetic** — Addition, multiplication, subtraction (predecessor), integer division, remainder, and GCD.
- **Integer Encoding** — Signed integers represented as ordered pairs `(positive, negative)` of naturals.
- **Integer Arithmetic** — Sum, subtraction, multiplication, division, remainder, and GCD for signed integers.
- **Comparison Operators** — `<`, `>`, `≤`, `≥`, `=` for both naturals and integers.
- **Church-Encoded Lists** — Linked lists with `head`, `tail`, `isEmpty`, `makeList`.
- **List Algorithms** — `sum`, `subtract`, `max`, and `min` operating entirely on Church-encoded data.
- **Y-Combinator Recursion** — All recursive operations use the fixed-point combinator, staying true to pure lambda calculus.
- **Canonical Reduction** — Integers are automatically reduced to their canonical equivalence class representative.

---

## 📂 Project Structure

```
church-numerals-racket/
├── src/
│   ├── churchNumerals.rkt      # Core library: booleans, pairs, naturals, integers, arithmetic
│   └── main.rkt                # List operations, algorithms, and test execution
├── examples/
│   ├── example1Pairs.rkt       # Introduction to Racket pairs (cons/car/cdr)
│   ├── example2SumList.rkt     # Recursive list summation using native Racket
│   ├── example3FirstElement.rkt# Safe head access with empty-list handling
│   └── example4LambdaFunctions.rkt # Lambda vs shorthand define syntax
├── docs/
│   └── informe.pdf             # Academic report / project documentation
├── .gitignore
└── README.md
```

| Directory    | Purpose |
|:-------------|:--------|
| `src/`       | Core Church encoding library and main entry point with list algorithms. |
| `examples/`  | Standalone beginner-friendly examples showcasing basic Racket/Scheme concepts. |
| `docs/`      | Academic documentation and project reports. |

---

## 🚀 Setup Guide

### Prerequisites

- [Racket](https://racket-lang.org/download/) ≥ 8.0

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/your-username/church-numerals-racket.git
cd church-numerals-racket

# 2. Run the main program
racket src/main.rkt
```

### Expected Output

```
=== TEST EXECUTION ===
List X is: [4, -2, 7, -1, 0, -5, nil]

Sum of elements in List X: 3
Subtraction block of elements in List X: 5
Max element in List X: 7
Min element in List X: -5

List Y is: [-3, 8, -6, 2, -4, 1, nil]

Sum of elements in List Y: -2
Subtraction block of elements in List Y: -4
Max element in List Y: 8
Min element in List Y: -6
```

### Running Examples

```bash
racket examples/example1Pairs.rkt
racket examples/example2SumList.rkt
racket examples/example4LambdaFunctions.rkt
```

---

## 👥 Contributors

| Name | Role |
|:-----|:-----|
| **Andrea Pascual Aguilera** | Developer & Co-Author |
| **Sergio Alonso Zarcero** | Developer & Co-Author |

---

## 🗺️ Future Roadmap

- [ ] **Rational Numbers** — Extend the encoding to support fractions `(p/q)` using pairs of integers and automatic GCD simplification.
- [ ] **Church-Encoded Binary Trees** — Implement BST insert, search, and traversal using only lambdas.
- [ ] **Interactive REPL Interface** — Build a custom REPL that lets users type arithmetic expressions and see both the Church-encoded and decoded results side-by-side.

---

## 🏷️ Suggested GitHub Topics

`lambda-calculus` · `church-encoding` · `racket` · `functional-programming` · `computer-science`

---

## 📄 License

This project is available under the [MIT License](LICENSE).
