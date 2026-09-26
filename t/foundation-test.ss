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
                 defpoo-object-family))
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
        (check-equal? (foundation->alist value) '((name . foundation)))))))
