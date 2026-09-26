# SPDX-FileCopyrightText: 2026 tao3k team and Contributors
# SPDX-License-Identifier: Apache-2.0 AND LGPL-2.1-or-later

set shell := ["bash", "-euo", "pipefail", "-c"]

gerbil_test_max_heap := env_var_or_default("GERBIL_TEST_MAX_HEAP", "1G")
gerbil_test_debug := env_var_or_default("GERBIL_TEST_DEBUG", "q")
gerbil_test_runtime_options := "-:max-heap=" + gerbil_test_max_heap + ",debug=" + gerbil_test_debug

default:
    @just --list

build:
    GERBIL_BUILD_VERBOSE=1 env -u SDKROOT gerbil build

test-file path:
    #!/usr/bin/env bash
    set -euo pipefail
    test -f "{{ path }}"
    output="$(env -u SDKROOT timeout --foreground --signal=TERM --kill-after=5s 120s gerbil {{ gerbil_test_runtime_options }} env gxtest "{{ path }}" 2>&1)" || { status=$?; printf '%s\n' "$output"; exit "$status"; }
    printf '%s\n' "$output"
    if grep -E 'ERROR (CHECK|CASE|HARNESS)|Heap overflow|Stack overflow' <<< "$output" >/dev/null; then exit 1; fi
    grep -F 'MODULE-OK {{ path }}' <<< "$output" >/dev/null
    grep -F 'HARNESS-OK' <<< "$output" >/dev/null
    grep -x 'OK' <<< "$output" >/dev/null

test:
    just test-file t/core-test.ss
