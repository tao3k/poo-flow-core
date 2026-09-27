#!/usr/bin/env gxi
;;; -*- Gerbil -*-
;;; SPDX-FileCopyrightText: 2026 tao3k team and Contributors
;;;
;;; SPDX-License-Identifier: Apache-2.0 AND LGPL-2.1-or-later

(import (only-in :std/build-script defbuild-script))

(defbuild-script
  '("types"
    "object-family/funcs"
    "object-family/indexed"
    "object-family/syntax"
    "object-family/interface"
    "extension-graph/support/data"
    "extension-graph/support/merge"
    "extension-graph/support/operation"
    "extension-graph/support/apply"
    "extension-graph/interface"
    "module-schema/support/contracts"
    "module-schema/support/merge"
    "module-schema/support/object-slots"
    "module-schema/support/object"
    "module-schema/interface"
    "module-schema/slot-contracts"
    "module-schema/relations"
    "module-schema/validation"
    "composition/lineage"
    "observability/types"
    "observability/funcs"
    "observability/slot-debug"
    "observability/slot-presentation"
    "observability/debug"
    "observability/testing-case"
    "poo-clos/types"
    "poo-clos/objects"
    "poo-clos/funcs"
    "poo-clos/lambda-list"
    "poo-clos/method-combination"
    "poo-clos/classes"
    "poo-clos/instance-state"
    "poo-clos/lifecycle"
    "poo-clos/dispatch"
    "poo-clos/evolution"
    "poo-clos/generic-evolution"
    "poo-clos/reflection"
    "poo-clos/load-form"
    "poo-clos/mop"
    "poo-clos/declaration-ir-core"
    "poo-clos/class-declaration-ir"
    "poo-clos/method-combination-declaration-ir"
    "poo-clos/declaration-ir"
    "poo-clos/syntax"
    "poo-clos/interface"))
