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
    "composition/lineage"
    "observability/types"
    "observability/funcs"
    "observability/slot-debug"
    "observability/debug"
    "observability/testing-case"))
