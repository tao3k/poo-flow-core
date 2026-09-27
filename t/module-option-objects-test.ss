;;; -*- Gerbil -*-
;;; SPDX-FileCopyrightText: 2026 tao3k team and Contributors
;;;
;;; SPDX-License-Identifier: Apache-2.0 AND LGPL-2.1-or-later

(import (only-in :std/test check-equal? test-suite)
        (only-in :clan/poo/object .ref object?)
        :core/observability/testing-case
        :core/module-system/projection/option-objects)

(export module-option-objects-test)

(def module-option-objects-test
  (test-suite "Core Module option POO values"
    (poo-flow-test-case "configuration, schema, and receipt preserve native slots"
      (let* ((config
              (make-poo-flow-module-option-config
               "enabled" #t 'module-a '((owner . core))))
             (schema
              (make-poo-flow-module-option-schema
               "enabled" 'module-a 'Boolean 'constant #t '()))
             (receipt
              (make-poo-flow-module-option-validation-receipt
               "enabled" 'module-a #t 'ok '() '())))
        (check-equal? (object? config) #t)
        (check-equal? (poo-flow-module-option-config? config) #t)
        (check-equal? (poo-flow-module-option-config-value config) #t)
        (check-equal? (poo-flow-module-option-schema? schema) #t)
        (check-equal? (poo-flow-module-option-schema-rule schema) 'constant)
        (check-equal? (poo-flow-module-option-validation-receipt? receipt) #t)
        (check-equal? (.ref receipt 'valid?) #t)))))
