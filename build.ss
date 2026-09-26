#!/usr/bin/env gxi
;;; -*- Gerbil -*-
;;; SPDX-FileCopyrightText: 2026 tao3k team and Contributors
;;;
;;; SPDX-License-Identifier: Apache-2.0 AND LGPL-2.1-or-later

(import (only-in :std/build-script defbuild-script))

(defbuild-script
  '("module-system/types"
    "module-system/object-family/funcs"
    "module-system/object-family/indexed"
    "module-system/object-family/syntax"
    "module-system/object-family/interface"
    "module-system/composition/lineage"
    "module-system/observability/types"
    "module-system/observability/funcs"
    "module-system/observability/slot-debug"
    "module-system/observability/debug"
    "module-system/observability/testing-case"))
