;;; -*- Gerbil -*-
;;; SPDX-FileCopyrightText: 2026 tao3k team and Contributors
;;;
;;; SPDX-License-Identifier: Apache-2.0 AND LGPL-2.1-or-later

(import (only-in :clan/poo/object .ref object?)
        (only-in :std/test check-equal? test-suite)
        (only-in :core/observability/testing-case poo-flow-test-case)
        :core/module-schema/interface
        :core/module-schema/validation)

(export module-schema-validation-test)

(def (schema-field identity type merge default metadata)
  (poo-flow-module-field-contract identity type merge default metadata))

(def module-schema-validation-test
  (test-suite "native POO module schema validation"
    (poo-flow-test-case "uses native Type and C4 without an ASP harness"
      (let* ((parent
              (poo-flow-module-object
               'schema.parent '()
               (list (schema-field 'name PooFlowModuleStringType
                                   'override "parent" '()))
               '()))
             (child
              (poo-flow-module-object
               'schema.child (list parent)
               (list (schema-field 'enabled PooFlowModuleBooleanType
                                   'override #t '()))
               '()))
             (validation (poo-flow-module-object-validation child))
             (summary
              (poo-flow-module-objects-validation-summary
               (poo-flow-module-objects-validation (list parent child)))))
        (check-equal? (poo-flow-module-object-validation? validation) #t)
        (check-equal? (eq? validation
                          (poo-flow-module-object-validation child))
                      #t)
        (check-equal? (poo-flow-module-object-validation-valid? validation)
                      #t)
        (check-equal? (.ref validation 'inheritance-chain)
                      '(schema.child schema.parent))
        (check-equal? (.ref validation 'resolved-field-identities)
                      '(name enabled))
        (check-equal? (map (lambda (origin) (.ref origin 'provider))
                           (.ref validation 'field-origins))
                      '(schema.parent schema.child))
        (check-equal? (.ref summary 'object-count) 2)
        (check-equal? (.ref summary 'invalid-count) 0)))

    (poo-flow-test-case "rejects invalid merge, metadata, and native default"
      (let* ((bad
              (poo-flow-module-object
               'schema.invalid '()
               (list (schema-field 'name PooFlowModuleStringType
                                   'unknown 42 'bad-metadata))
               '()))
             (validation (poo-flow-module-object-validation bad))
             (field-validation
              (car (.ref validation 'fieldContractValidations))))
        (check-equal? (poo-flow-module-object-validation-valid? validation)
                      #f)
        (check-equal? (object? field-validation) #t)
        (check-equal? (map (lambda (diagnostic) (.ref diagnostic 'code))
                           (.ref field-validation 'diagnostics))
                      '(unsupported-merge metadata-not-association-list
                        default-not-in-native-type))))))
