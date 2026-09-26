;;; -*- Gerbil -*-
;;; SPDX-FileCopyrightText: 2026 tao3k team and Contributors
;;;
;;; SPDX-License-Identifier: Apache-2.0 AND LGPL-2.1-or-later

(import (only-in :std/test test-suite test-case check-equal?)
        (only-in :clan/poo/object .o .ref)
        (only-in :clan/poo/mop define-type element?)
        (only-in :poo-flow-foundation/module-system/types
                 PooFlowNativeObjectContract.
                 poo-flow-predicate-contract
                 poo-flow-contract-admit
                 poo-flow-validation-evidence-accepted?)
        (only-in :poo-flow-foundation/module-system/object-family/syntax
                 defpoo-object-family)
        (only-in :poo-flow-foundation/module-system/composition/lineage
                 poo-flow-lineage-analysis
                 poo-flow-lineage-cycle?
                 poo-flow-productive-recursion?)
        (only-in :poo-flow-foundation/module-system/observability/debug
                 poo-flow-debug-memory-policy
                 poo-flow-debug-memory-snapshot)
        (only-in :poo-flow-foundation/module-system/observability/testing-case
                 poo-flow-default-testing-case-profile
                 poo-flow-testing-case-profile?
                 poo-flow-test-case/with))
(export foundation-test)

(define-type (FoundationNameContract @ PooFlowNativeObjectContract.)
  identity: 'foundation/name
  proto: (.o)
  responsibilities: (.o name: (poo-flow-predicate-contract
                              'foundation/name-symbol symbol?
                              (lambda (_candidate _context) '()))))

(defpoo-object-family
  (accessors (foundation-name name))
  (projections (foundation->alist (name name))))

(def +foundation-case-profile+
  (.o (:: @ poo-flow-default-testing-case-profile)
      (identity 'foundation/qualification)
      (memory-policy
       (poo-flow-debug-memory-policy
        'foundation/qualification heap-limit-bytes: 1073741824
        live-growth-limit-bytes: 536870912
        sample-interval-milliseconds: 10))
      (max-duration-milliseconds 2000)))

(def foundation-test
  (test-suite "POO Flow Foundation"
    (test-case "native contracts retain prototype ancestry"
      (let* ((proto (.ref FoundationNameContract 'proto))
             (value (.o (:: @ proto) name: 'foundation)))
        (check-equal? (element? FoundationNameContract value) #t)
        (check-equal? (poo-flow-validation-evidence-accepted?
                       (poo-flow-contract-admit FoundationNameContract value #f))
                      #t)
        (check-equal? (element? FoundationNameContract (.o name: 'foundation)) #f)))
    (test-case "object-family projection stays POO-native"
      (let (value (.o name: 'foundation))
        (check-equal? (foundation-name value) 'foundation)
        (check-equal? (foundation->alist value) '((name . foundation)))))
    (test-case "lineage distinguishes cycles and productive recursion"
      (check-equal? (poo-flow-lineage-cycle? '(a b c)) #f)
      (check-equal? (poo-flow-lineage-cycle? '(a b a)) #t)
      (check-equal? (poo-flow-productive-recursion? '(a b a) '(b)) #t)
      (check-equal? (poo-flow-productive-recursion? '(a b a) '(c)) #f)
      (check-equal? (.ref (poo-flow-lineage-analysis '(a b c) '(b)) 'status)
                    'acyclic)
      (check-equal? (.ref (poo-flow-lineage-analysis '(a b a) '(b)) 'status)
                    'productive-recursion)
      (check-equal? (.ref (poo-flow-lineage-analysis '(a b a) '(c)) 'status)
                    'non-productive-cycle))
    (test-case "Foundation samples Gambit memory without ASP"
      (let (sample (poo-flow-debug-memory-snapshot 'foundation/qualification))
        (check-equal? (.ref sample 'phase) 'foundation/qualification)
        (check-equal? (exact-integer? (.ref sample 'heap-size-bytes)) #t)))
    (poo-flow-test-case/with +foundation-case-profile+
      "Case profile extends Foundation memory and duration slots"
      (check-equal? (poo-flow-testing-case-profile?
                     +foundation-case-profile+) #t)
      (check-equal? (.ref +foundation-case-profile+ 'identity)
                    'foundation/qualification))))
