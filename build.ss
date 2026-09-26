#!/usr/bin/env gxi
;;; -*- Gerbil -*-
;;; SPDX-FileCopyrightText: 2026 tao3k team and Contributors
;;;
;;; SPDX-License-Identifier: Apache-2.0 AND LGPL-2.1-or-later

(import (only-in :std/build-script defbuild-script))

(defbuild-script
  '("src/module-system/types"
    "src/module-system/object-family/funcs"
    "src/module-system/object-family/indexed"
    "src/module-system/object-family/syntax"
    "src/module-system/object-family/interface"
    "src/module-system/observability/types"
    "src/module-system/observability/funcs"
    "src/module-system/observability/slot-debug"
    "src/module-system/observability/debug"))
