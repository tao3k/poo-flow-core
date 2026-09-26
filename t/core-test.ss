;;; -*- Gerbil -*-
;;; SPDX-FileCopyrightText: 2026 tao3k team and Contributors
;;;
;;; SPDX-License-Identifier: Apache-2.0 AND LGPL-2.1-or-later

(import (only-in :std/test test-suite test-case check-equal?)
        (only-in :clan/poo/object .o .ref)
        (only-in :clan/poo/mop define-type element?)
        (only-in :core/types
                 PooFlowNativeObjectContract.
                 poo-flow-predicate-contract
                 poo-flow-contract-admit
                 poo-flow-validation-evidence-accepted?)
        (only-in :core/object-family/syntax
                 defpoo-object-family)
        (only-in :core/composition/lineage
                 poo-flow-lineage-analysis
                 poo-flow-lineage-cycle?
                 poo-flow-productive-recursion?)
        (only-in :core/observability/debug
                 poo-flow-debug-memory-policy
                 poo-flow-debug-memory-snapshot)
        (only-in :core/observability/testing-case
                 poo-flow-default-testing-case-profile
                 poo-flow-testing-case-profile?
                 poo-flow-test-case/with))
(export core-test)

(define-type (CoreNameContract @ PooFlowNativeObjectContract.)
  identity: 'core/name
  proto: (.o)
  responsibilities: (.o name: (poo-flow-predicate-contract
                              'core/name-symbol symbol?
                              (lambda (_candidate _context) '()))))

(defpoo-object-family
  (accessors (core-name name))
  (projections (core->alist (name name))))

(def +core-case-profile+
  (.o (:: @ poo-flow-default-testing-case-profile)
      (identity 'core/qualification)
      (memory-policy
       (poo-flow-debug-memory-policy
        'core/qualification heap-limit-bytes: 1073741824
        live-growth-limit-bytes: 536870912
        sample-interval-milliseconds: 10))
      (max-duration-milliseconds 2000)))

(def core-test
  (test-suite "Core"
    (test-case "native contracts retain prototype ancestry"
      (let* ((proto (.ref CoreNameContract 'proto))
             (value (.o (:: @ proto) name: 'core)))
        (check-equal? (element? CoreNameContract value) #t)
        (check-equal? (poo-flow-validation-evidence-accepted?
                       (poo-flow-contract-admit CoreNameContract value #f))
                      #t)
        (check-equal? (element? CoreNameContract (.o name: 'core)) #f)))
    (test-case "object-family projection stays POO-native"
      (let (value (.o name: 'core))
        (check-equal? (core-name value) 'core)
        (check-equal? (core->alist value) '((name . core)))))
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
    (test-case "Core samples Gambit memory without ASP"
      (let (sample (poo-flow-debug-memory-snapshot 'core/qualification))
        (check-equal? (.ref sample 'phase) 'core/qualification)
        (check-equal? (exact-integer? (.ref sample 'heap-size-bytes)) #t)))
    (poo-flow-test-case/with +core-case-profile+
      "Case profile extends Core memory and duration slots"
      (check-equal? (poo-flow-testing-case-profile?
                     +core-case-profile+) #t)
      (check-equal? (.ref +core-case-profile+ 'identity)
                    'core/qualification))))
